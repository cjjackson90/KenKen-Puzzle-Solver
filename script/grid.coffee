class Grid
	
	# size of the grid.
	size: null

	# Array of cages which are contained in this grid.
	cages: []

	# 2d array of squares which corresponds to the grid
	# structure as it would be displayed.
	display: []

	# Single dimension representation of the squares
	# (and thus their values) when a solution has been found.
	solution: []

	# Array of Square[]. Each increasing index indicates the
	# squares that have been answered at each step.
	solution_order: []

	# 2d array, with the first dimension representing each row
	# and the second the values 1...grid_size. When a value is
	# known in a row it is removed from the relevent
	# row - either as it has already been added, or its position
	# is not known but cage is, thus it is accounted for.
	rows: []

	# 2d array, with the first dimension representing each column
	# and the second the values 1...grid_size. When a value is
	# known in a column it is removed from the relevent
	# column - either as it has already been added, or its position
	# is not known but cage is, thus it is accounted for.
	columns: []

	# ### Grid.constructor( grid_size )
	# Initialises grid by taking grid_size and creating
	# the necessary number of squares (grid elements)
	# ### Parameters
	# * `grid_size' - size of the grid
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

		$('#edit_grid_wrapper').remove()
		@draw()

	# ### Grid.draw
	# Draws the grid to the screen using jquery.
	draw: () ->
		$('#edit_mode').append('''
			<div id="edit_grid_wrapper">
			</div>
		''')

		for i in [0...@size]
			letter = String.fromCharCode( 65 + (i % @size))
			for j in [0...@size]
				num = j + 1
				$('#edit_grid_wrapper').append('<div id="'+letter+''+num+'"><div class="op_target">&nbsp;</div>&nbsp;</div>')

		sq_size = ( ( $('#edit_grid_wrapper').height() / @size ) )
		$('#edit_grid_wrapper > div, #grid_lines > div').css(
			"width": "#{sq_size}px"
			"height": "#{sq_size}px"
		)
	
	# ### Grid.clear( )
	# Reinitialises values to null/empty.
	clear: () ->
		size:null
		cages: []
		display: []
		solution: []
		rows: []
		columns: []

	# ### Grid.update_row( row_id, val )
	# Indicates that a particular value (val) in a
	# particular row (row_id) has been used.
	# ### Parameters
	# * `row_id' - the row id that has had the value removed.
	# * `val' - the value which has been removed.
	update_row: (row_id, val) ->
		@rows[row_id][val-1] = null

	# ### Grid.update_column( col_id, val )
	# Indicates that a particular value (val) in a
	# particular column (col_id) has been used.
	# ### Parameters
	# * `col_id' - the col id that has had the value removed.
	# * `val' - the value which has been removed.
	update_column: (col_id, val) ->
		@columns[col_id][val-1] = null
	
	# ### Grid.add_cage( cage )
	# Pushes a cage onto the list of all the grid's cages.
	# ### Parameters
	# * `cage' - the cage object to be added to the list of cages.
	add_cage: (cage) ->
		@cages.push cage

	# ### Grid.add_solution( )
	# Adds the solution to the grid by creating a single dimension
	# array of all the squares. This can be used to look up the
	# value of each square, to display to the user.
	add_solution: (solution) ->
		for i in [0...@size]
			for j in [0...@size]
				@solution.push @display[i][j]

	# ### Grid.add_solution_order( solution_order )
	# Sets the grid's solution order to be solution_order
	# ### Parameters
	# * `solution_order' - 2d array with each index storing an
	#	array of squares, indicating the order the solver determined
	#	their value.
	add_solution_order: (solution_order) ->
		@solution_order = solution_order

	# ### Grid.verify_correct( )
	# Checks the grid is correct or not by either checking the 
	# solution array (if it exists) or checking the rows/columns/cages
	# are consistent. Returns consistent if the grid is correct so far,
	# inconsistent if an anomaly has been found or valid if the grid is
	# complete and correct.
	verify_correct: () ->
		if @solution.length is []
			for i in [0..@size]
				if @display[i].value?
					if @display[i].value isnt @solution[i]
						return false
				else
					return false
		else
			row_check = @check_rows_are_valid( )
			if row_check.status is "inconsistent"
				return row_check
			
			col_check = @check_cols_are_valid( )
			if col_check.status is "inconsistent"
				return col_check

			if @check_cages_are_valid( ) is false
				if row_check.status is "consistent" and col_check.status is "consistent"
					return {status: "consistent"}
				else
					return {status: "inconsistent"}
			else
				return {status: "valid"}

	# ### Grid.check_rows_are_valid( )
	# Checks each row is valid by sorting the row and comparing
	# the sort to the numbers [1...grid_size]. If the sorted row
	# matches until a null is found (ie, row is not finished) this
	# returns "consistent". If the sorted row doesn't match at any
	# point we return "inconsistent". Otherwise (ie, all rows contain
	# all the numbers once) return "true".
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
					if sorted[i] is null
						return {status: "consistent"}
					else
						return {status: "inconsistent"}
		return valid

	# ### Grid.check_cols_are_valid( )
	# Checks each column is valid by sorting the column and comparing
	# the sort to the numbers [1...grid_size]. If the sorted column
	# matches until a null is found (ie, column is not finished) this
	# returns "consistent". If the sorted column doesn't match at any
	# point we return "inconsistent". Otherwise (ie, all columns contain
	# all the numbers once) return "true".
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
					if sorted[i] is null
						return {status: "consistent"}
					else
						return {status: "inconsistent"}
		return valid

	# ### Grid.check_cages_are_valid( )
	# Checks each cage in the grid to see its contained values match
	# its target when combined using its operator.
	check_cages_are_valid: ->
		for cage in @cages
			cage_nums = []
			for i in cage.location
				cage_nums.push i.value

			switch cage.operation
				when "+"
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
		return true		

	# ### Grid.cages_have_candidates( )
	# Checks all the cages have candidates. If at least one doesn't
	# return false, and true if they all have at least one candidate.
	# If a cage has no candidates the grid is invalid.
	cages_have_candidates: () ->
		for cage in @cages
			if cage.candidates is null
				for sq in cage.location
					if not sq.value?
						return false
		return true

	# ### Grid.get_square( square_id )
	# Returns the square object when passed a square id, such as B3.
	# ### Parameters
	# * `square_id' - the id we wish to return the object of, such as A2.
	get_square: (square_id) ->
		row = square_id.substring(0,1).charCodeAt(0) - 65 #Converts capital letter to row id; A=0, B=1, etc
		column = square_id.substring(1) - 1 #Makes index of column one = 0, etc 

		return @display[row][column]

	# ### Grid.ascending( a, b )
	# Used to allow the js.sort method to return numerically ascending
	# values as opposed to lexicographically ascending values.
	# eg, [9, 10, 54, 300] instead of [10, 300, 54, 9]
	ascending: (a,b) ->
		return a-b
	
	# ### Grid.descending( a, b )
	# Used to allow the js.sort method to return numerically descending
	# values, as opposed to lexicographically ascending values.
	# eg, [300, 54, 10, 9] instead of [10, 300, 54, 9]
	descending: (a,b) ->
		return b-a

	# ### Grid.remove( arr, val )
	# Returns array arr, with value val removed
	# ### Parameters
	# * `arr' - array from which we want to remove a value.
	# * `val' - value we wish to remove from arr.
	remove: (arr, val) ->
		x for x in arr when x!=val
	
	# ### Grid.remove_array( arr, val )
	# Returns array arr, with value val removed. Used instead
	# of 'remove(arr,val)' when val is an array.
	# ### Parameters
	# * `arr' - array from which we want to remove a value.
	# * `val' - value we wish to remove from arr.
	remove_array: (arr, val) ->
		output = []
		for current in arr
			mismatch = false
			for i in [0...current.length]
				if current[i] isnt val[i]
					mismatch = true
					break
			output.push current if mismatch is true
		return output

this.Grid = Grid