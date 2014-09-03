require 'spec_helper'

describe Piece do
  describe "#rotate" do
    let(:piece) { Piece.new :L }

    it "should rotate the piece clockwise" do
      expect(piece.rotate.value).to eq([
        [ :L, :L, :L],
        [ :L,nil,nil]
      ])
      expect(piece.rotate.rotate.value).to eq([
        [ :L, :L],
        [nil, :L],
        [nil, :L]
      ])
      expect(piece.rotate(2).value).to eq([
        [ :L, :L],
        [nil, :L],
        [nil, :L]
      ])
    end
  end

  describe "#bottom" do
    let(:piece) { Piece.new :Z }
    it "should respond with the bottom-heights of column" do
      expect(piece.bottom 0).to be(1);
      expect(piece.bottom 1).to be(0);
    end

    it "should still work after rotating" do
      expect(piece.rotate.bottom 0).to be(0)
      expect(piece.rotate.bottom 1).to be(1)
    end
  end

  describe "#bottoms" do
    let(:piece) { Piece.new :T }
    it "should respond with an array of bottom-heights for each column" do
      expect(piece.bottoms).to eq([1,0,1])
    end

    it "should still work after rotating" do
      expect(piece.rotate.bottoms).to eq([1,0])
    end
  end
end

