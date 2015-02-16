class Game < ActiveRecord::Base
  has_many :user_games
  has_many :users, through: :user_games
  serialize :board

   INITIAL_BOARD = [[0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0]]

  validates_length_of :users, maximum: 2, message: "can have at most two players."

  def self.waiting
    Game.where(:user_games_count => 1)
  end

  def self.active
    Game.where(:finished => false)
  end

  def new_board!
    self.update_attribute :board, INITIAL_BOARD
  end

  # runs the player's turn
  # def player_turn(pick, board, player_type)
  # 	if player_type == player1
  # 		piece = 'R'
  # 	else
  # 		piece = 'B'
  # 	end
  # 	column = pick - 1
  # 	board[pick-1] = place_piece(board[column], piece)
  # 	if self.won?(board, column)
  # 	end_of_turn
  #   end
  # end

  # places piece in the lowest available space in the chosen column
  def place_piece(column, piece)
  	i = 0
  	until column[i] == 'R' || column[i] == 'B' || column[i] == nil
  		i += 1
  	end
  	column[i-1] = piece
  	column
  end

  # runs check horizontal, check_vertical, and check_diagonal methods
  # returns true if there are four in a row in any axis
  def won?(board, column)
  	row = @i
  	# checks the horizontal axis, working left first and then right second
  	if check_horizontal(board, column, row) == true
  		return true
  	else
  		# checks the vertical axis, working down first and then up second
  		if check_vertical(board, column, row) == true
  			return true
  		else
  			# checks the diagonal axis running DOWN-LEFT to UP-RIGHT
  			if check_DL_UR_diagonal(board, column, row) == true
  				return true
  			else
  				# checks the diagonal axis running DOWN-RIGHT to UP-LEFT
  				if check_DR_UL_diagonal(board, column, row) == true
  					return true
  				else
  					return false
  				end
  			end
  		end
  	end
  end

  # checks the horizontal axis by incrementing columns left first (down), then right (column + 1
  def check_horizontal(board, start_column, row)
  	match_counter = 0
  	column = start_column
  	unless column - 1 < 0 || board[column][row] != board[column - 1][row] || match_counter == 4
  		match_counter += 1
  		column -= 1
  	end
  	column = start_column
  	unless column + 1 > 6 || board[column][row] != board[column + 1][row] || match_counter == 4
  		match_counter += 1
  		column += 1
  	end
  	if match_counter.size == 4
  		return true
  	else
  		return false
  	end
  end

  #checks the vertical axis by incrementing rows down first, up second
  def check_vertical(board, column, start_row)
  	match_counter = 0
  	row = start_row
  	unless row - 1 < 0 || board[column][row] != board[column][row - 1] || match_counter == 4
  		match_counter += 1
  		row -= 1
  	end
  	row = start_row
  	unless row + 1 > 5 || board[column][row] != board[column][row + 1] || match_counter == 4
  		match_counter += 1
  		row += 1
  	end
  	if match_counter.size == 4
  		return true
  	else
  		return false
  	end
  end

  #checks diagonals going down and left (first) and then up and right (second)
  def check_DL_UR_diagonal(board, start_column, start_row)
  	match_counter = 0
  	column = start_column
  	row = start_row
  	unless column - 1 < 0 || row - 1 < 0 || board[column][row] != board[column - 1][row - 1] || match_counter == 4
  		match_counter += 1
  		column -= 1
  		row -= 1
  	end
  	column = start_column
  	row = start_row
  	unless column + 1 > 6 || row + 1 > 5 || board[column][row] != board[column + 1][row + 1] || match_counter == 4
  		match_counter += 1
  		column += 1
  		row += 1
  	end
  	if match_counter.size == 4
  		return true
  	else
  		return false
  	end
  end

  # INVERSE of CHECK_DL_UR_DIAGONAL, goes down and right first, up and left second
  def check_DR_UL_diagonal(board, start_column, start_row)
  	match_counter = 0
  	column = start_column
  	row = start_row
  	# goes down and right first (column incremented up, row incremented down)
  	unless column + 1 < 6 || row - 1 < 0 || board[column][row] != board[column + 1][row - 1] || match_counter == 4
  		match_counter += 1
  		column += 1
  		row -= 1
  	end
  	column = start_column
  	row = start_row
  	# goes up and left second (column incremented down, row incremented up)
  	unless column - 1 < 0 || row + 1 > 5 || board[column][row] != board[column - 1][row + 1] || match_counter == 4
  		match_counter += 1
  		column -= 1
  		row += 1
  	end
  	if match_counter.size == 4
  		return true
  	else
  		return false
  	end
  end
end

