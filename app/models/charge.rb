class Charge < ApplicationRecord
    belongs_to :user
    belongs_to :game
  
    validates :game_id, presence: true
    validates :amount, presence: true, numericality: { greater_than: 0 }
    validates :date, presence: true

    mount_uploader :image, ImageUploader
end
  