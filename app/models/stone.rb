class Stone < ApplicationRecord
    belongs_to :user
    belongs_to :game
  
    # 目標のガチャ石の数に到達するまでの日数を計算するメソッド
    def days_to_reach_goal
      daily_total_stones = login + daily
      remaining_stones = goal - current

      # 最終更新日から現在までの経過日数を計算
      elapsed_days = (Time.zone.now.to_date - updated_at.to_date).to_i
      days = 0

      # 経過日数分、remaining_stonesを減算
      elapsed_days.times do |day|
        remaining_stones -= daily_total_stones
      end
  
      while remaining_stones > 0
        days += 1
        remaining_stones -= daily_total_stones
      end
  
      days
    end
end