class Game < ActiveRecord::Base
  has_many :user_games
  has_many :users, through: :user_games
  serialize :board




  def initialize
  	@turncount = 0
    @open = true
    @finished = false

    # each sub-array is a column, not a row! THIS LAYOUT IS MISLEADING!
  	@board = [['o', 'o', 'o', 'o', 'o', 'o'],
  	 		      ['o', 'o', 'o', 'o', 'o', 'o'],
  	 		      ['o', 'o', 'o', 'o', 'o', 'o'],
  	 		      ['o', 'o', 'o', 'o', 'o', 'o'],
  	 		      ['o', 'o', 'o', 'o', 'o', 'o'],
  	 		      ['o', 'o', 'o', 'o', 'o', 'o'],
  	 		      ['o', 'o', 'o', 'o', 'o', 'o']]
  	@i = 0
  	self.create(:board => @board, :turncount => @turncount, )
  end

  # do I need to have a display_board method in the model? That sounds like a controller/view job.
  # perhaps this is used to build how the board is supposed to look and then it hands that to the controller?
  # ASK BRIT!
  def display_board(board)
  	# TODO: find a way to format the board! 

    "

      #{board[0][0]} | #{board[1][0]} | #{board[2][0]} | #{board[3][0]} | #{board[4][0]} | #{board[5][0]} | #{board[6][0]}
      __________________________________

      #{board[0][1]} | #{board[1][1]} | #{board[2][1]} | #{board[3][1]} | #{board[4][1]} | #{board[5][1]} | #{board[6][1]}
      __________________________________

      #{board[0][2]} | #{board[1][2]} | #{board[2][2]} | #{board[3][2]} | #{board[4][2]} | #{board[5][2]} | #{board[6][2]}
      __________________________________

      #{board[0][3]} | #{board[1][3]} | #{board[2][3]} | #{board[3][3]} | #{board[4][3]} | #{board[5][3]} | #{board[6][3]}
      __________________________________

      #{board[0][4]} | #{board[1][4]} | #{board[2][4]} | #{board[3][4]} | #{board[4][4]} | #{board[5][4]} | #{board[6][4]}
      __________________________________

      #{board[0][5]} | #{board[1][5]} | #{board[2][5]} | #{board[3][5]} | #{board[4][5]} | #{board[5][5]} | #{board[6][5]}


    "
  end


  # sets the game state to finished
  def finished!
    @finished = true
  end

  # sets game state to closed (happens when player 2's position is filled! Game will not be initialized until player 2 is found)
  def closeGame!
    @open = false
  end



  # runs the player's turn
  def player_turn(pick, board)
  	if turncount.odd?
  		piece = 'R'
  	else
  		piece = 'B'
  	end
  	column = pick - 1
  	board[pick-1] = place_piece(board[column], piece)
  	if self.won?(board, column)
      game.finished!
    end
  	end_of_turn
  end

  # places piece in the lowest available space in the chosen column
  def place_piece(column, piece)
  	@i = 0
  	until column[@i] == 'R' || column[@i] == 'B' || column[@i] == nil
  		@i += 1
  	end
  	column[@i-1] = piece
  	column
  end

  # runs check horizontal, check_vertical, and check_diagonal methods
  # returns true if there are four in a row in any axis
  def won?(board, column)
  	row = @i
  	# checks the horizontal axis, working left first and then right second 
  	if check_horizontal(board, column, row) == true
  		return true
  	elsif check_vertical(board, column, row) == true
      return true
    elsif check_DL_UR_diagonal(board, column, row) == true
      return true
    elsif check_DR_UL_diagonal(board, column, row) == true
      return true
    else
      return false
    end
  end

  # checks the horizontal axis by incrementing columns left first (down), then right (column + 1)
  def check_horizontal(board, start_column, row)
  	match_counter = 0
  	column = start_column
  	while column - 1 > 0 && board[column][row] == board[column - 1][row] && match_counter < 3
  		match_counter += 1
  		column -= 1
  	end
  	column = start_column
  	while column + 1 < 6 || board[column][row] == board[column + 1][row] && match_counter < 3
  		match_counter += 1
  		column += 1
  	end
  	if match_counter == 3
  		return true
  	else
  		return false
  	end
  end

  #checks the vertical axis by incrementing rows down first, up second
  def check_vertical(board, column, start_row)
  	match_counter = 0
  	row = start_row
  	unless row - 1 < 0 || board[column][row] != board[column][row - 1] || match_counter == 3
  		match_counter += 1
  		row -= 1
  	end
  	row = start_row
  	unless row + 1 > 5 || board[column][row] != board[column][row + 1] || match_counter == 3
  		match_counter += 1
  		row += 1
  	end
  	if match_counter == 3
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
  	unless column - 1 < 0 || row - 1 < 0 || board[column][row] != board[column - 1][row - 1] || match_counter == 3
  		match_counter += 1
  		column -= 1
  		row -= 1
  	end
  	column = start_column
  	row = start_row
  	unless column + 1 > 6 || row + 1 > 5 || board[column][row] != board[column + 1][row + 1] || match_counter == 3
  		match_counter += 1
  		column += 1
  		row += 1
  	end
  	if match_counter == 3
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
  	unless column + 1 < 6 || row - 1 < 0 || board[column][row] != board[column + 1][row - 1] || match_counter == 3
  		match_counter += 1
  		column += 1
  		row -= 1
  	end
  	column = start_column
  	row = start_row
  	# goes up and left second (column incremented down, row incremented up)
  	unless column - 1 < 0 || row + 1 > 5 || board[column][row] != board[column - 1][row + 1] || match_counter == 3
  		match_counter += 1
  		column -= 1
  		row += 1
  	end
  	if match_counter == 3
  		return true
  	else
  		return false
  	end
  end

  def end_of_turn
    @turncount += 1
    self.save
  end

end
