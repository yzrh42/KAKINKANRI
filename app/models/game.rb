class Game < ApplicationRecord
    belongs_to :user
    has_many :gachas
    has_many :charges
    has_many :stones

    validates :name, presence: true, uniqueness: true


    before_destroy :check_associated_records

    private

    def check_associated_records
        if gachas.exists? || charges.exists? || stones.exists?
            errors.add(:base, '関連するデータが存在するため削除できません')
            throw(:abort)
        end
    end
end
