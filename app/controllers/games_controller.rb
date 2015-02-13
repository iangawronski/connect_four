class GamesController < ApplicationController
  before_action :set_users


  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
  end

private

  def set_user
    @user = Users.all
  end

  def game_params
    params.require(:game).permit(:users)
  end

end
