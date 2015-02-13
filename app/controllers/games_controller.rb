class GamesController < ApplicationController
  #before_action :set_users


  def index
    @games = Game.all
  end

  def new
    @game = Game.new
    render :join
  end

  def create
    @game = Game.new#(game_params)
    @game.save
  end

  def join
    @game = Game.find([params[:id]])
  end

private

  def set_user
    @user = Users.find(current_user)
  end

  # def game_params
  #   params.require(:game).permit(:users)
  # end

end
