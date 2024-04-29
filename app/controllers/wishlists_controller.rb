class WishlistsController < ApplicationController
    def index
        @wishlists = current_user.wishlists
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
          redirect_to wishlists_path, success: '記録を更新しました'
        else
          flash.now[:danger] = '記録を更新できませんでした'
          render :edit
        end
    end
    
    def destroy
        @wishlist = Wishlist.find(params[:id])
        @wishlist.destroy!
        redirect_to wishlists_path, success: '予算を削除しました'
    end
    
    private
    
    def wishlist_params
        params.require(:wishlist).permit(:user_id, :name, :price, :is_purchasable)
    end
end
