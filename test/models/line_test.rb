require "test_helper"

class LineTest < ActiveSupport::TestCase
    def setup
        @line = Line.new
    end
    
    test "line should not be invalid without missing properties" do
        refute @line.valid?
        assert_not_nil @line.errors[:board_id]
    end
    
    test "board should valid with valid properties" do
        board = Board.new
        @line.board = board
        assert @line.valid?
    end
end