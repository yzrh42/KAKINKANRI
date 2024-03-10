class Charge < ApplicationRecord
    belongs_to :user
    belongs_to :game
    belongs_to :budget, optional: true
  
    validates :game_id, presence: true
    validates :amount, presence: true, numericality: { greater_than: 0 }
    validates :date, presence: true

    mount_uploader :image, ImageUploader

    def self.ransackable_attributes(auth_object = nil)
        ["amount", "budget_id", "created_at", "date", "game_id", "image", "memo", "updated_at", "user_id"]
    end
end
  