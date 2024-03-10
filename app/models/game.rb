class Game < ApplicationRecord
    belongs_to :user
    has_many :gachas
    has_many :charges
    has_many :stones

    validates :name, presence: true
end
