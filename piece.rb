PIECES = [
  [
    [nil, :S, :S],
    [ :S, :S,nil]
  ],
  [
    [ :Z, :Z,nil],
    [nil, :Z, :Z]
  ],
  [
    [ :T, :T, :T],
    [nil, :T,nil]
  ],
  [
    [ :L,nil],
    [ :L,nil],
    [ :L, :L]
  ],
  [
    [nil, :J],
    [nil, :J],
    [ :J, :J]
  ],
  [
    [ :I],
    [ :I],
    [ :I],
    [ :I]
  ],
  [
    [ :O, :O],
    [ :O, :O]
  ]
]

PIECE_LETTERS = [:S,:Z,:T,:L,:J,:I,:O]

class Piece
  def initialize type, orientation = 0
    @type = type.is_a?(Fixnum) ?
      type : PIECE_LETTERS.find_index(type.to_sym)
    @piece = PIECES[@type].map(&:dup)
    @orientation = orientation
    rotate! orientation
  end
  def rotate! n=1
    n.times do
      @piece = @piece.reverse.transpose
    end
    @orientation = (@orientation+n)%4
    self
  end
  def type
    @type
  end
  def rotate n=1
    self.dup.rotate! n
  end
  def dup
    Piece.new @type, @orientation
  end
  def place board, x
    board.place self, x
  end
  def bottom x
    rotate.value[x].each_with_index do |v,i|
      return i unless v.nil?
    end
    b
  end
  def bottoms
    rotate.value.map do |col|
      b = 0
      col.each_with_index do |v,i|
        b = i
        break unless v.nil?
      end
      b
    end
  end
  def width
    @piece[0].size
  end
  def height
    @piece.size
  end
  def data
    @piece.reverse
  end
  def value
    @piece
  end
end
