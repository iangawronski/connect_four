class GamesController < ApplicationController
  before_action :set_user
  before_action :set_game, only: [:join, :move, :show_game]


  def index
    @games = Game.all
  end

  def new
    @game = Game.new
    render :join
  end

  def create
    @game = Game.new(game_params)
    @game.save
  end

  def join
    @game = Game.find([params[:id]])
    @game.player2 = current_user.id
  end

  def move
    if @game.can_move?(current_user.id)
      @game.player_move(params[:column])

  end

  def show_game

  end
private

  def set_game
    @game = Games.find(params[:id])
  end

  def set_user
    @user = Users.find(current_user)
  end

  def set_board
    if params[:id]
      @game = set_game
      @board = @game.board
    else


end
