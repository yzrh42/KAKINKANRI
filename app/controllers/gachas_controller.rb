class GachasController < ApplicationController
    before_action :authenticate_user!

    def index
        @gachas = current_user.gachas
    end
    
    def new
        @gacha = Gacha.new
        @games = current_user.games
    end
    
    def create
        @gacha = current_user.gachas.new(gacha_params)
        if @gacha.save
          redirect_to gachas_path, success: '登録しました'
        else
          @games = current_user.games
          flash.now[:danger] = '登録できませんでした'
          render :new
        end
    end

    def show
        @gacha = Gacha.find(params[:id])
    end

    def edit
        @gacha = Gacha.find(params[:id])
        @games = current_user.games
    end

    def update
        @gacha = current_user.gachas.find(params[:id])
        if @gacha.update(gacha_params)
          redirect_to gachas_path, success: '記録を更新しました'
        else
          @games = current_user.games
          flash.now[:danger] = '記録を更新できませんでした'
          render :edit
        end
    end
    
    def destroy
        @gacha = Gacha.find(params[:id])
        @gacha.destroy!
        redirect_to gachas_path, success: '予算を削除しました'
    end
    
    private
    
    def gacha_params
        params.require(:gacha).permit(:user_id, :game_id, :amount, :number, :date, :image, :memo)
    end
end