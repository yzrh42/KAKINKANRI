class Stone < ApplicationRecord
    belongs_to :user
    belongs_to :game
  
    # 目標のガチャ石の数に到達するまでの日数を計算するメソッド
    def days_to_reach_goal
      daily_total_stones = login + daily
      remaining_stones = goal - current
      days = 0
  
      while remaining_stones > 0
        days += 1
        remaining_stones -= daily_total_stones
      end
  
      days
    end
end