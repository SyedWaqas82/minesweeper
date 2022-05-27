require "test_helper"

class BoardTest < ActiveSupport::TestCase
  def setup
    @board = Board.new
    #@board = boards(:invalid)
  end

  test "board should not be invalid without nil properties" do
    refute @board.valid?
    assert @board.still_playing?
    assert_not_nil @board.errors[:width]
    assert_not_nil @board.errors[:height]
    assert_not_nil @board.errors[:bombs_count]
  end

  test "board should valid with valid properties" do
    @board.width = 9
    @board.height = 9
    @board.bombs_count = 10

    assert @board.valid?
    assert @board.still_playing?
    assert_equal 0, @board.lines.size
  end
end
