require 'cell'
require 'line'

class BoardService

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

  private

  def add_bombs(scheme, board)
    board.bombs_count.times do |index|
      bomb = create_bomb(board.height, board.width)
      while board.lines[bomb.line].cells[bomb.col].is_bomb? == true
        bomb = create_bomb(board.height, board.width)
      end
      board.lines[bomb.line].cells[bomb.col].bomb = true
    end
  end

  def create_bomb(height, width)
    bomb = OpenStruct.new
    bomb.line = rand(height)
    bomb.col = rand(width)
    bomb
  end

end