require "board_service" 

class BoardsController < ActionController::API
  before_action :set_board, only: [:playing, :flag, :play, :destroy]

  def initialize
    @board_svc = BoardService.new
  end

  # GET /status
  def playing
    render json: {'playing' => @board.still_playing?}, status: :ok
  end

  # PATCH /flag
  def flag
    begin
      @board_svc.flag(params["line"], params["column"], @board)
      @board.reload
      render json: @board.to_json(include: {lines: {include: :cells} }), status: :ok
    rescue RuntimeError => r
      render json: {'error' => r.message}, status: :bad_request
    end
  end

  # PATCH /play
  def play
    begin
      @board_svc.valid_play?(params["line"], params["column"], @board)
      @board_svc.play(params["line"], params["column"], @board)

      @board.lines[params["line"]].cells.each do |cell|
        cell.save
      end
      @board.reload
      @board.save
      render json: @board.to_json(include: {lines: {include: :cells} }), status: :ok

    rescue RuntimeError => r
      render json: {'error' => r.message}, status: :bad_request
    end
  end

  # POST /board
  def create
    begin
      @board = Board.new(board_params)

      @board_svc.create_cells(@board)

      if @board.save
        render json: @board.to_json(include: {lines: {include: :cells} }), status: :created
      else
        render json: @board.errors, status: :unprocessable_entity
      end
    rescue Exception => e
      render json: e, status: :unprocessable_entity
    end
  end

  # DELETE /board/1
  def destroy
    @board.destroy
  end

   # GET /leaderboard
   def leaderboard
    topscorers = Leaderboard.order("clicks, time").take(10);
    render json: topscorers, status: :ok
  end

  #POST /leaderboard
  def newscore
    begin
      newscore = Leaderboard.new(newscore_params)

      if newscore.save
        render json: newscore, status: :created
      else
        render json: newscore.errors, status: :unprocessable_entity
      end
    rescue Exception => e
      render json: e, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def board_params
      params.require(:board).permit(:height, :width, :bombs_count)
    end

    def newscore_params
      params.permit(:name, :clicks, :time)
    end
end
