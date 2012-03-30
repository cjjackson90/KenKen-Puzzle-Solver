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

	cages_have_candidates: () ->
		for cage in cages
			if cage.candidates is null
				return false
		return true

	get_square: (square_id) ->
		#console.log("trying to get "+square_id)

		row = square_id.substring(0,1).charCodeAt(0) - 65 #Converts capital letter to row id; A=0, B=1, etc
		column = square_id.substring(1) - 1 #Makes index of column one = 0, etc 
		#console.log(row + " "+ column)
		return @display[row][column]

this.Grid = Grid