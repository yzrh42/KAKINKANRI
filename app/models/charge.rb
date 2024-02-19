class Charge < ApplicationRecord
    belongs_to :user
  
    validates :game, presence: true
    validates :amount, presence: true
    validates :date, presence: true
end
  