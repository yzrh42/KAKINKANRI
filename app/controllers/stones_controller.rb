class StonesController < ApplicationController
    def index
        @stones = current_user.stones
        @games = Game.includes(:charges).all
    end
    
    def new
        @stone = Stone.new
        @games = Game.where(user_id: [current_user.id, nil]).order(name: :asc)
    end
    
    def create
        @stone = current_user.stones.new(stone_params)
        existing_stone = Stone.find_by(game_id: @stone.game_id)
        if existing_stone
            flash.now[:danger] = "#{existing_stone.game.name}はすでに登録されています"
            render :new
            return
        end
        if @stone.save
          redirect_to stones_path, success: '登録しました'
        else
          @games = Game.where(user_id: [current_user.id, nil]).order(name: :asc)
          flash.now[:danger] = '登録できませんでした'
          render :new
        end
    end

    def show
        @stone = Stone.find(params[:id])
    end

    def edit
        @stone = Stone.find(params[:id])
        @games = Game.where(user_id: [current_user.id, nil]).order(name: :asc)
    end

    def update
        @stone = current_user.stones.find(params[:id])
        if @stone.update(stone_params)
          redirect_to stones_path, success: '記録を更新しました'
        else
          @games = Game.where(user_id: [current_user.id, nil]).order(name: :asc)
          flash.now[:danger] = '記録を更新できませんでした'
          render :edit
        end
    end
    
    def destroy
        @stone = Stone.find(params[:id])
        @stone.destroy!
        redirect_to stones_path, success: '予算を削除しました'
    end
    
    private
    
    def stone_params
        params.require(:stone).permit(:user_id, :game_id, :goal, :login, :daily, :current)
    end
end