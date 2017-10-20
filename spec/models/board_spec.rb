require 'rails_helper'

RSpec.describe Board, type: :model do

  describe "Validity of Board model" do

    context ":cmm factory" do

      before :each do
        @valid_board = build :board
      end

      it ":board factory should build a valid object" do
        expect(@valid_board).to be_valid(Board)
      end

      it "saving a new board should change the number of elements on DB" do
        expect {@valid_board.save}.to change {Board.count}.by 1
      end
    end
  end
end
