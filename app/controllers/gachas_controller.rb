class GachasController < ApplicationController
    def index
        @gachas = current_user.gachas
    end
    
    def new
        @gacha = Gacha.new
        @games = Game.where(user_id: [current_user.id, nil]).order(name: :asc)
    end
    
    def create
        @gacha = current_user.gachas.new(gacha_params)
        if @gacha.save
          redirect_to gachas_path, success: '登録しました'
        else
          @games = Game.where(user_id: [current_user.id, nil]).order(name: :asc)
          flash.now[:danger] = '登録できませんでした'
          render :new
        end
    end

    def show
        @gacha = Gacha.find(params[:id])
    end

    def edit
        @gacha = Gacha.find(params[:id])
        @games = Game.where(user_id: [current_user.id, nil]).order(name: :asc)
    end

    def update
        @gacha = current_user.gachas.find(params[:id])
        if @gacha.update(gacha_params)
          redirect_to gachas_path, success: '記録を更新しました'
        else
          @games = Game.where(user_id: [current_user.id, nil]).order(name: :asc)
          flash.now[:danger] = '記録を更新できませんでした'
          render :edit
        end
    end
    
    def destroy
        @gacha = Gacha.find(params[:id])
        @gacha.destroy!
        redirect_to gachas_path, success: '予算を削除しました'
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
    
    def gacha_params
        params.require(:gacha).permit(:user_id, :game_id, :amount, :number, :date, :image, :memo)
    end
end