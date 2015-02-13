class GamesController < ApplicationController
  #before_action :set_users


  def index
    @games = Game.all
  end

  def new
<<<<<<< HEAD
  	
  end

  def create

  end

  def destroy

  end

  def play

  end
=======
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
>>>>>>> ea92043b6e35cf946580ebfde99d335cf1d3e7d9

end
