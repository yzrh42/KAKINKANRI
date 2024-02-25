class ChargesController < ApplicationController
    before_action :authenticate_user!

    def index
        @charges = current_user.charges.order(date: :asc)
    end
    
    def new
        @charge = Charge.new
        @games = current_user.games
    end
    
    def create
        @charge = current_user.charges.new(charge_params)
        if @charge.save
          redirect_to charges_path(@charge), success: '登録しました'
        else
          flash.now[:danger] = '登録できませんでした'
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
        params.require(:charge).permit(:user_id, :game_id, :amount, :date, :image, :memo)
    end
end
