require "test_helper"

class BoardsControllerTest < ActionDispatch::IntegrationTest
    test "create new game with valid params" do
        attribs = boards(:valid)

        post "/board", params: {board: attribs}, as: :json
        assert_response :created
        assert_equal response.content_type, "application/json; charset=utf-8"
        lastBoard = Board.last
        assert_equal attribs.height, lastBoard.lines.size
        assert_equal attribs.width, lastBoard.lines[0].cells.size
        assert_equal attribs.bombs_count, lastBoard.bombs_count

        body = JSON.parse(response.body)

        assert_equal attribs.height, body['lines'].count
        assert_equal attribs.width, body['lines'][0]['cells'].count
        assert_equal attribs.bombs_count, body['bombs_count']
    end

    test "create new game with invalid params" do
        attribs = boards(:invalid)
        post "/board", params: {board: attribs}, as: :json
        assert_response :unprocessable_entity
        assert_equal response.content_type, "application/json; charset=utf-8"
    end

    test "create new game with invalid params 2" do
        post "/board", params: {board: Board.new}, as: :json
        assert_response :unprocessable_entity
        assert_equal response.content_type, "application/json; charset=utf-8"
    end

    test "status" do
        attribs = boards(:valid)

        post "/board", params: {board: attribs}, as: :json
        boardBody = JSON.parse(response.body)

        get "/status?id=" + boardBody["id"].to_s
        assert_response :ok
        assert_equal response.content_type, "application/json; charset=utf-8"
        assert JSON.parse(response.body)["playing"]
    end

    test "flagged valid" do
        line = 1
        column = 1
        attribs = boards(:valid)

        post "/board", params: {board: attribs}, as: :json
        boardBody = JSON.parse(response.body)

        patch "/flag?id=" + boardBody["id"].to_s, params: {"line": line, "column": column}, as: :json
        assert_response :ok
        assert_equal response.content_type, "application/json; charset=utf-8"

        assert Board.last.lines[line].cells[column].flag
    end

    test "flagged invlaid" do
        line = 100
        column = 1
        attribs = boards(:valid)

        post "/board", params: {board: attribs}, as: :json
        boardBody = JSON.parse(response.body)

        patch "/flag?id=" + boardBody["id"].to_s, params: {"line": line, "column": column}, as: :json
        assert_response :bad_request
        assert_equal response.content_type, "application/json; charset=utf-8"
    end

    test "play valid" do
        line = 1
        column = 1
        attribs = boards(:valid)

        post "/board", params: {board: attribs}, as: :json
        boardBody = JSON.parse(response.body)

        patch "/play?id=" + boardBody["id"].to_s, params: {"line": line, "column": column}, as: :json
        assert_response :ok
        assert_equal response.content_type, "application/json; charset=utf-8"

        assert Board.last.lines[line].cells[column].discovered
    end

    test "play invalid" do
        line = 100
        column = 1
        attribs = boards(:valid)

        post "/board", params: {board: attribs}, as: :json
        boardBody = JSON.parse(response.body)

        patch "/play?id=" + boardBody["id"].to_s, params: {"line": line, "column": column}, as: :json
        assert_response :bad_request
        assert_equal response.content_type, "application/json; charset=utf-8"
    end

    test "leaderboar valid" do
        attribs = leaderboards(:valid)

        post "/leaderboard", params: attribs, as: :json
        assert_response :created
        assert_equal response.content_type, "application/json; charset=utf-8"
        lastLeaderBoard = Leaderboard.last
        assert_equal attribs.name, lastLeaderBoard.name
        assert_equal attribs.clicks, lastLeaderBoard.clicks
        assert_equal attribs.time, lastLeaderBoard.time

        body = JSON.parse(response.body)

        assert_equal attribs.name, body['name']
        assert_equal attribs.clicks, body['clicks']
        assert_equal attribs.time, body['time']

        get "/leaderboard"
        assert_response :ok
        assert_equal response.content_type, "application/json; charset=utf-8"
        getBody = JSON.parse(response.body)

        assert getBody.count > 0
    end

    test "leaderboar invalid" do
        attribs = leaderboards(:invalid)

        post "/leaderboard", params: attribs, as: :json
        assert_response :unprocessable_entity
        assert_equal response.content_type, "application/json; charset=utf-8"
    end
end
