require 'pry'
	column = 'oooobw'

  	i = 0
  	until column[i] == 'w' || column[i] == 'b' || column[i] == nil
  		i += 1
  	end
  	column[i-1] = 'b'

  		binding.pry