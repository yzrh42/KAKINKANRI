class Budget < ApplicationRecord
    has_many :charges

    validates :year, presence: true
    validates :month, presence: true
    validates :amount, presence: true
end