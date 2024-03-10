class ChargesController < ApplicationController
    before_action :authenticate_user!

    def index
        @q = current_user.charges.ransack(params[:q])
        @charges = @q.result.distinct.order(date: :asc)
        @data_for_chart = @charges.joins(:game).group("strftime('%Y-%m', date)", "games.name").sum(:amount)
        @games = current_user.games
    end
    
    def new
        @charge = Charge.new
        @games = current_user.games
    end
    
    def create
        @charge = current_user.charges.new(charge_params)
        if @charge.save
          redirect_to charges_path, success: '登録しました'
        else
          @games = current_user.games
          flash.now[:danger] = '登録できませんでした'
          Rails.logger.info(@charge.errors.full_messages)
          render :new
        end
    end

    def show
        @charge = Charge.find(params[:id])
    end

    def edit
        @charge = current_user.charges.find(params[:id])
        @games = current_user.games
    end

    def update
        @charge = current_user.charges.find(params[:id])
        if @charge.update(charge_params)
          redirect_to charge_path(@charge), success: '記録を更新しました'
        else
          @games = current_user.games
          flash.now[:danger] = '記録を更新できませんでした'
          render :edit
        end
    end
    
    def destroy
        @charge = Charge.find(params[:id])
        @charge.destroy!
        redirect_to charges_path, success: '記録を削除しました'
    end
    
    private
    
     def charge_params
        params.require(:charge).permit(:user_id, :game_id, :amount, :date, :image, :memo, :budget_id)
    end
end
