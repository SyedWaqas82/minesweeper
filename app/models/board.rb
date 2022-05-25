Dir.glob('app/validators/board*').each do |v|
    require_relative "../../#{v}"
end

class Board < ApplicationRecord
    has_many :lines, dependent: :destroy

    validates_with BoardValidator

    def still_playing?
        playing
    end
end
