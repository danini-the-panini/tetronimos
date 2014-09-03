require 'spec_helper'

describe Board do
  let(:piece) { Piece.new :T }
  describe "#place" do
    context "when board is empty" do
      let(:board) { Board.new 4, 4 }

      it "should drop the piece on the bottom row" do
        new_board = board.place piece, 1

        expect(new_board.value).to eq([
          [nil,nil,nil,nil],
          [nil,nil,nil,nil],
          [nil, :T, :T, :T],
          [nil,nil, :T,nil]
        ])
      end
    end

    context "when the board is not empty" do
      let(:board) { Board.new [
          [nil,nil,nil,nil],
          [nil,nil,nil,nil],
          [nil, :Z,nil,nil],
          [ :Z, :Z,nil,nil]
        ] }

      it "should drop piece onto existing blocks" do
        new_board = board.place piece, 1

        expect(new_board.value).to eq([
          [nil,nil,nil,nil],
          [nil, :T, :T, :T],
          [nil, :Z, :T,nil],
          [ :Z, :Z,nil,nil],
        ])
      end
    end
  end

  describe "#height_at" do
    context "when column is empty" do
      let(:board) { Board.new [
        [nil,nil, :I],
        [ :O,nil, :I],
        [ :O,nil, :I]
      ] }
      it "should respond with zero" do
        expect(board.height_at 1).to be(0)
      end
    end

    context "when column is full" do
      let(:board) { Board.new [
        [nil, :L, :I],
        [ :O, :L, :I],
        [ :O, :L, :I]
      ] }
      it "should respond with height of board" do
        expect(board.height_at 1).to be(3)
      end
    end

    context "When column is half-full" do
      let(:board) { Board.new [
        [nil,nil, :I],
        [ :O, :L, :I],
        [ :O, :L, :I]
      ] }
      it "should respond somewhere in between" do
        expect(board.height_at 1).to be(2)
      end
    end

    context "when column has a hole" do
      let(:board) { Board.new [
        [nil, :L, :I],
        [ :O,nil, :I],
        [ :O, :L, :I]
      ] }
      it "should respond with a value higher than the hole's position" do
        expect(board.height_at 1).to be(3)
      end
    end
  end
end
