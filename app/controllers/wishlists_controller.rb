class WishlistsController < ApplicationController
    def index
        @current_year_balance = current_user.monthly_balance(Date.today.year)
        @available_balance = @current_year_balance.values.sum
        @wishlists = current_user.wishlists.order(:position)
    end
    
    def new
        @wishlist = Wishlist.new
    end
    
    def create
        @wishlist = current_user.wishlists.new(wishlist_params)
        if @wishlist.save
          redirect_to wishlists_path, success: '登録しました'
        else
          flash.now[:danger] = '登録できませんでした'
          render :new
        end
    end

    def show
        @wishlist = Wishlist.find(params[:id])
    end

    def edit
        @wishlist = Wishlist.find(params[:id])
    end

    def update
        @wishlist = current_user.wishlists.find(params[:id])
        if @wishlist.update(wishlist_params)
          redirect_to wishlists_path, success: '更新しました'
        else
          flash.now[:danger] = '更新できませんでした'
          render :edit
        end
    end
    
    def destroy
        @wishlist = Wishlist.find(params[:id])
        @wishlist.destroy!
        redirect_to wishlists_path, success: '欲しいものを削除しました'
    end

    def move_higher
        Wishlist.find(params[:id]).move_higher
        redirect_to action: :index
    end
      
    def move_lower
        Wishlist.find(params[:id]).move_lower
        redirect_to action: :index
    end

    def purchase
        @wishlist = Wishlist.find(params[:id])
        @wishlist.update(purchased_at: Time.current)
        redirect_to wishlists_path, notice: '購入済に変更しました。'
    end

    def purchased
        @wishlists = Wishlist.where.not(purchased_at: nil)
    end
      
    
    private
    
    def wishlist_params
        params.require(:wishlist).permit(:user_id, :name, :price, :is_purchasable, :position)
    end
end
