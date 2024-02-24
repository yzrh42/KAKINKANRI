class GamesController < ApplicationController
    before_action :authenticate_user!

    def index
        @games = current_user.games
    end
    
    def new
        @game = Game.new
    end
    
    def create
        @game = current_user.games.new(game_params)
        if @game.save
          redirect_to games_path, success: '登録しました'
        else
          flash.now[:danger] = '登録できませんでした'
          render :new
        end
    end

    def show
        @game = Game.find(params[:id])
    end

    def edit
        @game = current_user.games.find(params[:id])
    end

    def update
        @game = current_user.games.find(params[:id])
        if @game.update(game_params)
          redirect_to game_path, success: '記録を更新しました'
        else
          flash.now[:danger] = '記録を更新できませんでした'
          render :edit
        end
    end
    
    def destroy
        @game = Game.find(params[:id])
        @game.destroy!
        redirect_to games_path, success: '記録を削除しました'
    end
    
    private
    
     def game_params
        params.require(:game).permit(:user_id, :name)
    end
end