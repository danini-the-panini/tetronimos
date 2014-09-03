




class Generator
  def initialize
    @pieces = PIECE_LETTERS.shuffle
  end
  def generate
    @pieces = PIECE_LETTERS.shuffle if @pieces.empty?
    @pieces.pop
  end
end
class Player
  def play p, n, board
    bwidth = board[0].size

    o = rand(4)
    piece = PIECES[p]
    o.times do
      piece = rotate(piece)
    end
    pwidth = piece[0].width
    x = rand(0..bwidth-pwidth)

    return [x, o]
  end
end

class Visualizer
  def initialize player, generator
    @player = player
    @generator = generator
    @board = Array.new(29) { Array.new(10, nil) }
    @next = @generator.generator
  end
  def board
    @board
  end
  def play board
    p = @next
    @next = @generator.generator
    x, o = player.play p, @next, board
    piece = rotate PIECES[p], o
    place(board,piece,x)
  end
  def place board, piece, x
    top = 0
    bottoms(piece).each_with_index do |b,i|
      h = height board, x+i
      th = h-b
      top = top>th ? top : th
    end
    upiece = piece.reverse
    (top..top+piece.size).each do |i|
      board[i][x..piece[0].size] = upiece[i-top]
    end
  end
  def height board, x
    h = nil
    (board.length-1...0).each do |i|
      if board[i][x].nil?
        h = i
        break
      end
    end
    h || board.length
  end
end

