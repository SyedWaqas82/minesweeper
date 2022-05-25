class BoardService
  
  def initialize
    @cell_svc = CellService.new
  end

  def create_cells(board)
    cells_matrix = []
    board.height.times do |line|
      l = Line.new
      values = []
      board.width.times do |col|
        values[col] = Cell.new
      end
      l.cells = values
      cells_matrix[line] = l
    end
    board.lines = cells_matrix

    add_bombs(cells_matrix, board)
  end

  def flag(line, column, board)
    raise 'Game Over' if not board.still_playing?

    valid_play?(line, column, board)

    @cell_svc.flag(line, column, board)
  end

  def play(line, column, board)
    raise 'Game Over' if not board.still_playing?
    valid_play?(line, column, board)
    
    if hit_bomb?(line, column, board)
      board.playing = false
      board.save!
      raise 'Hit a bomb'
    end

    @cell_svc.discover(line, column, board)
  end

  def valid_play?(line, column, board)
    valid = true
    if line.to_i > board.lines.size
      valid = false
    elsif column.to_i > board.lines[0].cells.size
      valid = false
    elsif column.to_i < 0 or line.to_i < 0
      valid = false
    end
    
    raise 'Invalid play: Index out of bounds ' if not valid
  end

  private

  def add_bombs(scheme, board)
    board.bombs_count.times do |index|
      bomb = create_bomb(board.height, board.width)
      while board.lines[bomb.line].cells[bomb.col].is_bomb? == true
        bomb = create_bomb(board.height, board.width)
      end
      board.lines[bomb.line].cells[bomb.col].bomb = true
      board.lines[bomb.line].cells[bomb.col].close_bombs = 0
      # Mark all the neighbour cells
      mark_cell(board, bomb.line - 1, bomb.col)
      mark_cell(board, bomb.line - 1, bomb.col + 1)
      mark_cell(board, bomb.line - 1, bomb.col - 1)
      mark_cell(board, bomb.line, bomb.col + 1)
      mark_cell(board, bomb.line, bomb.col - 1)
      mark_cell(board, bomb.line + 1, bomb.col)
      mark_cell(board, bomb.line + 1, bomb.col + 1)
      mark_cell(board, bomb.line + 1, bomb.col - 1)
    end
  end

  def create_bomb(height, width)
    bomb = OpenStruct.new
    bomb.line = rand(height)
    bomb.col = rand(width)
    bomb
  end

  def mark_cell(board, line, col)
    return if board.lines.size <= line or board.lines[0].cells.size <= col
    return if line < 0 or col < 0
    if not board.lines[line].cells[col].is_bomb?
      board.lines[line].cells[col].close_bombs += 1
    end
  end

  def hit_bomb?(line, column, board)
    if board.lines[line].cells[column].is_bomb?
      true
    else
      false
    end
  end
end
