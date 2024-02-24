class Game < ApplicationRecord
    belongs_to :user
    has_many :charges

    validates :name, presence: true
end
