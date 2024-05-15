class UsersController < ApplicationController
    skip_before_action
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
          # サインアップ後、ユーザーをログインさせる(オプション)
          sign_in(@user)
          # サインアップ後のリダイレクト先
          redirect_to new_user_sessions_path, flash[:notice] =  '登録されました'
        else
          render :new
        end
    end

    def gacha_ban_period
      game_id = params[:game_id]
      last_gacha_date = current_user.gachas.where(game_id: game_id).order(date: :desc).limit(1).pluck(:date).first
      if last_gacha_date.nil?
        @gacha_ban_days = 0
      else
        @gacha_ban_days = (Date.today - last_gacha_date.to_date).to_i
      end
    end
end
