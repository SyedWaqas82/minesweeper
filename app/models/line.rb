class Line < ApplicationRecord
  belongs_to :board
  has_many :cells, dependent: :destroy
end
