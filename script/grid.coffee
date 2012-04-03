class Grid
	
	size: null
	cages: []
	display: []
	solution: []
	rows: []
	columns: []


	constructor: (grid_size) ->
		@size = grid_size
		for i in [0...@size]
			@rows[i] = []
			@columns[i] = []
			@display[i] = []
			for j in [0...@size]
				@rows[i][j] = j+1
				@columns[i][j] = j+1
				@display[i][j] = new Square(i,j)
	
	add_candidate: () ->

	draw: () ->

	clear: () ->

	update_row: (row_id, col_id, val) ->

	update_column: (row_id, col_id, val) ->
		
	add_cage: (cage) ->
		@cages.push cage

	remove_cage: () ->

	add_solution: (solution) ->
		@solution = solution

	verify_correct: () ->
		valid = true
		if solution isnt null
			for i in [0..@size]
				if display[i].value isnt solution[i]
					return false
		else
			if check_rows_are_valid( ) is false
				return false
			if check_cols_are_valid( ) is false
				return false
			if check_cages_are_valid( ) is false
				return false
			return valid

	check_rows_are_valid: () ->
		cmp = [1..@size]
		valid = true
		for row in [0...@size]
			current_row = []
			for element in [0...@size]
				current_row.push @display[row][element].value

			sorted = current_row.sort(@ascending)

			for i in [0...sorted.length]
				if sorted[i] isnt cmp[i]
					return false
				# console.log "won't see this..."
				# valid = true
		return valid

	check_cols_are_valid: ->
		cmp = [1..@size]
		valid = true
		for col in [0...@size]
			current_col = []
			for element in [0...@size]
				current_col.push @display[element][col].value
			
			sorted = current_col.sort(@ascending)
			for i in [0...sorted.length]
				if sorted[i] isnt cmp[i]
					return false
			# if current_col.sort is cmp
			# 	valid = true
			# else
			# 	return false
		return valid

	check_cages_are_valid: ->
		for cage in @cages
			cage_nums = []
			for i in cage.location
				cage_nums.push i.value

			switch cage.operation
				when "+"
					# sorted = cage_nums.sort(@ascending)
					cage_value = 0
					for i in cage_nums
						cage_value += i
					if cage_value isnt cage.target
						return false
				when "-"
					sorted = cage_nums.sort(@descending)
					cage_value = sorted[0]
					for i in sorted[1...sorted.size]
						cage_value -= i
					if cage_value isnt cage.target
						return false
				when "*"
					# sorted = cage_nums.sort(@ascending)
					cage_value = 1
					for i in cage_nums
						cage_value *= i
					if cage_value isnt cage.target
						return false
				when "/"
					sorted = cage_nums.sort(@descending)
					cage_value = sorted[0]
					for i in sorted[1...sorted.size]
						cage_value /= i
					if cage_value isnt cage.target
						return false
				# when "-"
				# 	current_cage = []
				# 	for i in cage.location
				# 		current_cage.push i.value
				# 	current_cage.sort
				# 	for i in [current_cage.le]
				# 	for i in cage.location
				# 		cage_value -= i.value 
				# when "*"

				# when "/"

			# return false if cage_value isnt cage.target 
		return true		




	cages_have_candidates: () ->
		for cage in @cages
			if cage.candidates is null
				return false
		return true

	get_square: (square_id) ->
		#console.log("trying to get "+square_id)

		row = square_id.substring(0,1).charCodeAt(0) - 65 #Converts capital letter to row id; A=0, B=1, etc
		column = square_id.substring(1) - 1 #Makes index of column one = 0, etc 
		#console.log(row + " "+ column)
		return @display[row][column]

	# These two functions allow the js sort method to sort numerically
	# as opposed to lexicographically
	descending: (a,b) ->
		return b-a

	ascending: (a,b) ->
		return a-b

this.Grid = Grid