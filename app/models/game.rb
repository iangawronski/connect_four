class Game < ActiveRecord::Base
  has_many :user_games
  has_many :users, through: :user_games

  def display_board(board)

  end

  def player1_turn(column)
  	i = 0
  	until column[i] == 'w' || column[i] == 'b' || column[i] == nil
  		i += 1
  	end
  	column[i-1] = 'w'
  end

  def player2_turn(column)
  	i = 0
  	until column[i] == 'w' || column[i] == 'b' || column[i] == nil
  		i += 1
  	end
  	column[i-1] = 'b'
  end

  def won?(board)

  end


end
