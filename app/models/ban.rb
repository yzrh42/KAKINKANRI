class Ban < ApplicationRecord
    belongs_to :user
    belongs_to :game

    validates :start_date, presence: true
end