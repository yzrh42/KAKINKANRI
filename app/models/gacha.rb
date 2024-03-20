class Gacha < ApplicationRecord
    belongs_to :user
    belongs_to :game

    validates :number, presence: true
    validates :date, presence: true

    mount_uploader :image, ImageUploader

end