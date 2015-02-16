class GamesController < ApplicationController
  before_action :authenticate_user!, :only => [:join, :move]



  def index
    @games = Game.all
  end

  # def new
  #   @game = Game.new
  #   #render :join
  # end

  # def create
  #   @game = Game.create
  #   @game.save
  #   render :show
  # end

  def join
    @waiting = Game.waiting.first
    if @waiting
      @waiting.users << current_user
      redirect_to game_show_path(@waiting)
    else
      @game = Game.create
      @game.users = [current_user]
      @game.new_board!
      redirect_to game_show_path(@game)
    end
    # redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @player1 = @game.users.first
    @player2 = @game.users.second
  end

  def set_board
    @board = [['o', 'o', 'o', 'o', 'o', 'o', 'o'],
              ['o', 'o', 'o', 'o', 'o', 'o', 'o'],
              ['o', 'o', 'o', 'o', 'o', 'o', 'o'],
              ['o', 'o', 'o', 'o', 'o', 'o', 'o'],
              ['o', 'o', 'o', 'o', 'o', 'o', 'o'],
              ['o', 'o', 'o', 'o', 'o', 'o', 'o']]
  end


  def move
    if @game.can_move?(current_user)
      @game.player_move(params[:column])
      redirect_to game_show(@game)
    else
      redirect_to game_show(@game), notice: "It isn't your turn!"
    end

  end

private

  def game_params
    params.require(:game).permit(:users, :current_player, :id)
  end


end
