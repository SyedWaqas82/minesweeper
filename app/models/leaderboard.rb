class Leaderboard < ApplicationRecord
    validates :name, :clicks, :time, presence: true
end
