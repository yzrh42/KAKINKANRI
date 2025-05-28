class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]

  has_many :charges
  has_many :budgets
  has_many :games
  has_many :gachas
  has_many :stones
  has_many :wishlists
  has_many :bans

  def self.from_omniauth(auth)
    # providerとuidでユーザーを検索
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize do |u|
      # ユーザーが存在しない場合は新しく作成
      u.email = auth.info.email || "#{auth.uid}@example.com" # メールアドレスがない場合の仮のメールアドレス
      u.password = Devise.friendly_token[0,20] # パスワードはランダムに生成
      u.name = auth.info.name
      u.line_profile_image = auth.info.image
    end

    # ユーザーがDBに存在しない（新規作成）か、情報が更新された場合に保存
    if user.new_record? || user.changed?
      user.save
    end
    user
  end
  
  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end

  def set_values(omniauth)
    return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]
    credentials = omniauth["credentials"]
    info = omniauth["info"]

    access_token = credentials["refresh_token"]
    access_secret = credentials["secret"]
    credentials = credentials.to_json
    name = info["name"]
    # self.set_values_by_raw_info(omniauth['extra']['raw_info'])
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
  end

  def total_purchased_amount(year)
    start_date = Date.new(year, 1, 1)
    end_date = start_date.end_of_year
    
    wishlists.where(purchased_at: start_date..end_date).sum(:price)
  end

  def monthly_balance(year, include_purchases: true)
    monthly_balances = {}
    (1..12).each do |month|
      monthly_budget = budgets.find_by(year: year, month: month)
      next if monthly_budget.nil?
  
      start_date = Date.new(year, month, 1)
      end_date = start_date.end_of_month
  
      monthly_charge = charges.where(date: start_date..end_date).sum(:amount)
      purchased_total = include_purchases ? wishlists.where(purchased_at: start_date..end_date).sum(:price) : 0
  
      monthly_balances[month] = monthly_budget.amount - monthly_charge - purchased_total
    end
    monthly_balances
  end
end
