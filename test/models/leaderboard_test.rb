require "test_helper"

class LeaderboardTest < ActiveSupport::TestCase
  def setup
    @leaderBoard = Leaderboard.new
  end

  test "leaderboard should not be invalid without nil properties" do
    refute @leaderBoard.valid?
    assert_not_nil @leaderBoard.errors[:name]
    assert_not_nil @leaderBoard.errors[:clicks]
    assert_not_nil @leaderBoard.errors[:time]
  end

  test "leaderboard should valid with valid properties" do
    @leaderBoard.name = "Syed"
    @leaderBoard.clicks = 10
    @leaderBoard.time = 20

    assert @leaderBoard.valid?
  end
end


