class Game < ActiveRecord::Base
  has_many :user_games
  has_many :users, through: :user_games
  serialize :board



  # def set_board
  #   @board = [['o', 'o', 'o', 'o', 'o', 'o'],
  #             ['o', 'o', 'o', 'o', 'o', 'o'],
  #             ['o', 'o', 'o', 'o', 'o', 'o'],
  #             ['o', 'o', 'o', 'o', 'o', 'o'],
  #             ['o', 'o', 'o', 'o', 'o', 'o'],
  #             ['o', 'o', 'o', 'o', 'o', 'o'],
  #             ['o', 'o', 'o', 'o', 'o', 'o']]
  # end

  # def new_game(game_params)
  # 	@turncount = 0
  #   @open = true
  #   @finished = false
  #   @player1 = game_params[:user_id]
  #   # each sub-array is a column, not a row! THIS LAYOUT IS MISLEADING!
  # 	@board = set_board
  # 	@i = 0
  #   self.save(:turncount => @turncount, :board => @board, :player1_id => @player1.id)
  # end


  # sets the game state to finished
  def finished!
    true
  end

  # sets game state to closed (happens when player 2's position is filled! Game will not be initialized until player 2 is found)
  def closeGame!
    false
  end




  def can_move?(current_user)
    if current_user.id == self.users.first && self.turncount.odd?
      true
    else
      false
    end
  end





  # runs the player's turn
  def player_move(params[:column])
    if !self.finished
  	  if turncount.odd?
  		  piece = 'R'
  	  else
  		  piece = 'B'
    	end
  	  if board[column][0] == 'o' 
        board[pick-1] = place_piece(board[column], piece)
      else
        redirect_to :show, notice: "That column is already full!"
      end

  	  if self.finished?(board, column)
        game.finished!
        break
      end
  	  end_of_turn
    end
    else
      redirect_to :index
    end
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

  # checks the vertical axis by incrementing rows UP first, DOWN second
  # incrementing 'row' UP moves the checker DOWN
  def check_vertical(board, column, start_row)
  	match_counter = 0
  	row = start_row
  	while row - 1 > 0 && board[column][row] == board[column][row - 1] && match_counter < 3
  		match_counter += 1
  		row -= 1
  	end
  	row = start_row
  	while row + 1 < 5 && board[column][row] == board[column][row + 1] && match_counter < 3
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
  def check_DR_UL_diagonal(board, start_column, start_row)
  	match_counter = 0
  	column = start_column
  	row = start_row
  	while column - 1 > 0 && row - 1 > 0 && board[column][row] == board[column - 1][row - 1] && match_counter < 3
  		match_counter += 1
  		column -= 1
  		row -= 1
  	end
  	column = start_column
  	row = start_row
  	while column + 1 < 6 && row + 1 < 5 && board[column][row] == board[column + 1][row + 1] && match_counter < 3
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

  # INVERSE of CHECK_DR_UL_DIAGONAL, goes up and right first, down and left second
  def check_DL_UR_diagonal(board, start_column, start_row)
  	match_counter = 0
  	column = start_column
  	row = start_row
  	# goes down and right first (column incremented up, row incremented down)
  	while column + 1 < 6 && row - 1 > 0 && board[column][row] == board[column + 1][row - 1] && match_counter < 3
  		match_counter += 1
  		column += 1
  		row -= 1
  	end
  	column = start_column
  	row = start_row
  	# goes up and left second (column incremented down, row incremented up)
  	while column - 1 > 0 && row + 1 < 5 && board[column][row] == board[column - 1][row + 1] && match_counter < 3
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

  def finished?
    if self.won?(board, column) || @turncount == 42
      self.finished!
    end
  end



  def end_of_turn
    @turncount += 1
    self.update(:turncount => @turncount, :board => @board)
  end

end
