class BansController < ApplicationController
    before_action :gacha_ban_period, only: :index

    def index
        @bans = current_user.bans
        @games = Game.where(user_id: [current_user.id, nil]).order(name: :asc)
        @ban_days_by_game = calculate_ban_days_by_game
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
  
      if game_id.present?
        @game = Game.find(game_id)
        last_gacha_date = current_user.bans.where(game_id: game_id).order(start_date: :desc).limit(1).pluck(:start_date).first
  
        if last_gacha_date.nil?
          @gacha_ban_days = 0
        else
          @gacha_ban_days = (Date.today - last_gacha_date.to_date).to_i
        end
      else
        @gacha_ban_days = 'N/A'
        @game = nil
      end
    end
  
    
    private

    def calculate_ban_days_by_game
      result = {}
  
      @games.each do |game|
        ban = current_user.bans.find_by(game_id: game.id)
        gacha_date = current_user.gachas.where(game_id: game.id).order(date: :desc).limit(1).pluck(:date).first
  
        if gacha_date.present? && (ban.nil? || gacha_date > ban.start_date)
          # ガチャ記録の日付が存在し、かつbanが存在しないか、banのstart_dateより新しい場合
          start_date = gacha_date
        elsif ban.present?
          start_date = ban.start_date
        else
          start_date = nil
        end
  
        if start_date
          result[game.id] = (Date.today - start_date.to_date).to_i
        else
          result[game.id] = 'N/A'
        end
      end
  
      result
    end
    
    def ban_params
        params.require(:ban).permit(:user_id, :game_id, :start_date)
    end
end