require "board_service" 

class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :update, :destroy]

  def initialize
    @board_svc = BoardService.new
  end

  # GET /status
  def playing
    @board = Board.first
    render json: {'playing' => @board.still_playing?}, status: :ok
  end

  # PATCH /flag
  def flag
    @board = Board.first

    begin
      @board_svc.flag(params["line"], params["column"], @board)
      @board.reload
      render json: @board, status: :ok
    rescue
      render json: {'error' => r.message}, status: :bad_request
    end
  end

  # PATCH /play
  def play
    @board = Board.first

    begin
      @board_svc.valid_play?(params["line"], params["column"], @board)
      @board_svc.play(params["line"], params["column"], @board)
      @board.reload
      @board.save
      render json: @board, status: :ok
    rescue RuntimeError => r
      render json: {'error' => r.message}, status: :bad_request
    end
  end

  # POST /boards
  def create
    begin
      if not Board.all.empty?
        Board.delete_all
      end
      @board = Board.new(board_params)

      @board_svc.create_cells(@board)

      if @board.save
        render json: @board, status: :created
      else
        render json: @board.errors, status: :unprocessable_entity
      end
    rescue Exception => e
      render json: e, status: :unprocessable_entity
    end
  end

  # DELETE /boards/1
  def destroy
    @board.destroy
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
end
