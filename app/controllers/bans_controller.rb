class BansController < ApplicationController
    def index
        @bans = current_user.bans
    end
    
    def new
        @ban = Ban.new
        @games = Game.where(user_id: [current_user.id, nil]).order(name: :asc)
    end
    
    def create
        @ban = current_user.bans.new(ban_params)
        if @ban.save
          redirect_to bans_path, success: '登録しました'
        else
          @games = Game.where(user_id: [current_user.id, nil]).order(name: :asc)
          flash.now[:danger] = '登録できませんでした'
          render :new
        end
    end

    def show
        @ban = Ban.find(params[:id])
    end

    def edit
        @ban = Ban.find(params[:id])
        @games = Game.where(user_id: [current_user.id, nil]).order(name: :asc)
    end

    def update
        @ban = current_user.bans.find(params[:id])
        if @ban.update(ban_params)
          redirect_to bans_path, success: '変更しました'
        else
          @games = Game.where(user_id: [current_user.id, nil]).order(name: :asc)
          flash.now[:danger] = '変更できませんでした'
          render :edit
        end
    end
    
    def destroy
        @ban = Ban.find(params[:id])
        @ban.destroy!
        redirect_to bans_path, success: '登録を削除しました'
    end

    def gacha_ban_period
        game_id = params[:game_id]
        @game = Game.find(game_id)
        last_gacha_date = current_user.gachas.where(game_id: game_id).order(date: :desc).limit(1).pluck(:date).first
        if last_gacha_date.nil?
          @gacha_ban_days = 0
        else
          @gacha_ban_days = (Date.today - last_gacha_date.to_date).to_i
        end
    end
    
    private
    
    def ban_params
        params.require(:ban).permit(:user_id, :game_id, :start_date)
    end
end