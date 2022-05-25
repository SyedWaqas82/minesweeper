class Cell < ApplicationRecord
  belongs_to :line

  def is_bomb?
    return bomb
  end
end
