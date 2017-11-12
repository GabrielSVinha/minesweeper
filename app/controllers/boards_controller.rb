require "board_service" 

class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :update, :destroy]

  def initialize
    @board_svc = BoardService.new
  end

  # GET /boards
  def index
    @boards = Board.all

    render json: @boards
  end

  # GET /board/1
  def show
    render json: @board
  end

  # GET /status
  def playing
    @board = Board.first
    render json: {'playing' => @board.still_playing?}, status: :ok
  end

  # PUT /play
  def play
    @board = Board.first
    puts @board.lines[0].cells[0].discovered
    begin
      @board_svc.valid_play?(params["line"], params["column"], @board)
      puts @board.lines[0].cells[0].discovered
      @board_svc.play(params["line"], params["column"], @board)
      puts @board.lines[0].cells[0].discovered
      @board.reload
      render json: @board, status: :ok
    rescue RuntimeError => r
      render json: {'error' => r.message}, status: :bad_request
    end
  end

  # POST /boards
  def create
    @board = Board.new(board_params)
    if not Board.all.empty?
      Board.delete_all
    end

    @board_svc.create_cells(@board)

    if @board.save
      render json: @board, status: :created
    else
      render json: @board.errors, status: :unprocessable_entity
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
