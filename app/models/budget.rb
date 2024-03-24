class Budget < ApplicationRecord
    belongs_to :user
    has_many :charges

    validates :year, presence: true
    validates :month, presence: true
    validates :amount, presence: true
end