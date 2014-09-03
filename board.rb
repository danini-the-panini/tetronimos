class Board
  def initialize rows=29, cols=10
    if rows.is_a? Array
      @board = rows
    else
      @board = Array.new(rows) { Array.new(cols, nil) }
    end
  end
  def place! piece, x
    h = 0
    piece.bottoms.each do |b,i|
      h = max(height(x+i)-b, h)
    end
    place_at x, h, piece.data
  end
  def place piece, x
    self.dup.place! piece, x
  end
  def height_at x
    @board.reverse.each_with_index do |row,ii|
      i = height-ii-1
      return i+1 if !row[x].nil?
    end
    0
  end
  def dup
    Board.new @board.map(&:dup)
  end
  def print
    board.reverse.each do |row|
      puts row
    end
    nil
  end
  def height
    @board.size
  end
  def width
    @board[0].size
  end
  def value
    @board.map(&:dup)
  end
  private
    def max(a,b)
      a>b ? a : b
    end
    def place_at x, h, data
      data.each_with_index do |r,i|
        r.each_with_index do |c,j|
          @board[x+i][h+j] ||= c
        end
      end
    end
end
