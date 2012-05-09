class Solver
	
	# Stores the order that values are entered into the grid.
	solution_order: []

	# Stores an instance of the Strategies class.
	strat: null
	
	# ### Solver.constructor( )
	# Creates new instance of the Strategies class for later use.
	constructor: () ->
		@strat = new Strategies()
	
	# ### Solver.solve( grid, depth )
	# The main solve algorithm. Takes a grid instance, applies
	# strategies to it and uses backtracking if necessary. It
	# returns an object containing the status (valid, invalid)
	# and, if appropriate, a grid object.
	# ### Parameters
	# * `grid' - the grid instance we wish to solve.
	# * `depth' - the current depth of the search tree.
	solve: (grid, depth) ->
		if depth > 1000
			return_obj = 
				status: "invalid"
			return return_obj

		grid_complete = true
		for i in [0...grid.size]
			for j in [0...grid.size]
				if grid.display[i][j].value is null
					grid_complete = false
					break

		verified_correct = grid.verify_correct()

		if verified_correct.status is "valid"
			return_obj =
				status: "valid"
				valid_grid: grid
			return return_obj

		if verified_correct.status is "inconsistent"
			return_obj = 
				status: "invalid"
			return return_obj

		if grid.cages_have_candidates( ) is false
			return_obj = 
				status:"invalid"
			return return_obj

		test = @strat.one_candidate( grid )

		if test.status is true
			console.log "strat1 = success!"
			@append_solution_order( test.vals )
			for sq in test.vals
				temp = @update_puzzle_info( grid, sq.row_id, sq.column_id, sq.cage_id, sq.value )
				grid = temp

			return_obj = @solve(grid, depth+1)
			switch return_obj.status
				when "valid"
					return return_obj
				when "invalid"
					return {status:"invalid"}
		
		test2 = @strat.common_numbers( grid )

		if test2.status is true
			console.log "strat2 = success!"
			for obj in test2.vals
				console.log "obj.cage_id = #{obj.cage_id}"
				if obj.row_or_col is "row"
					grid = @update_puzzle_info( grid, obj.id, -1, obj.cage_id, obj.val )
				else
					grid = @update_puzzle_info( grid, -1, obj.id, obj.cage_id, obj.val)

			if depth > 5
				return_obj =
					status:"debug"
					grid:test2.grid
				return return_obj

			return_obj = @solve(grid, depth+1)
			switch return_obj.status
				when "valid"
					return return_obj
				when "invalid"
					return {status:"invalid"}

		potentials = @get_potentials(grid)

		for new_grid in potentials
			return_obj = @solve( new_grid, depth+1 )
			switch return_obj.status
				when "update"
					return return_obj
				when "valid"
					return return_obj

		return {status:"invalid"}			

	# ### Solver.get_potentials( grid )
	# Finds potential grids that exist on the next search step.
	# Decides on a profitable cage (this version chooses the cage
	# with the smallest number of candidates), and for each of the
	# candidates of the profitable cage creates a clone of the current
	# grid with the candidate added.
	# ### Parameters
	# * `grid' - grid instance we wish to find the potential child grids of
	get_potentials: (grid) ->
		profitable_cage = null # Chose some method of selecting a profitable cage for backtracking.
		potentials = []
		smallest_cage = grid.cages[0]
		first_index = 0

		for i in [0...grid.cages.length]
			viable_cage = false
			for sq in grid.cages[i].location
				if sq.value is null
					viable_cage = true
					break
			if viable_cage is true
				smallest_cage = grid.cages[i]
				first_index = i
				break

		smallest_length = smallest_cage.candidates.length
		for cage in grid.cages[first_index+1...grid.cages.length]
			viable = false
			if cage.candidates.length isnt 0
				for square in cage.location
					if square.value is null
						viable = true
						break

			if cage.candidates.length < smallest_length and viable
				smallest_cage = cage
				smallest_length = cage.candidates.length

		profitable_cage = smallest_cage

		for prof_candidate in profitable_cage.candidates
			temp = @clone ( grid )
			for cage in temp.cages
				for i in [0...cage.location.length]
					cage.location[i] = temp.get_square( cage.location[i].id )
				if cage.id is profitable_cage.id
					cage.add_candidate_to_grid(prof_candidate)
			potentials.push @clone temp

		potentials

	# ### Solver.append_solution_order( fresh_vals )
	# Pushes the latest added values onto the array maintaining
	# the solution order.
	append_solution_order: (fresh_vals) ->
		@solution_order.push fresh_vals

	# ### Solver.update_puzzle_info( grid, row_id, col_id, cage_id, fresh_val)
	# Updates the puzzle info by adding a value to the grid (if possible)
	# removing from the rows/columns maintainer a value which is accounted
	# for (removes from both if value location known, or only one if its
	# location is only known in a row/column) and updates the valid
	# candidates of the affected cages.
	# ### Parameters
	# * `grid' - the grid instance we wish to update.
	# * `row_id' - the row we wish to update. -1 if unknown.
	# * `col_id' - the column we wish to update. -1 if unknown.
	# * `cage_id' - the cage of the updated val
	# * `fresh_val' - the value which is to be updated and/or removed
	#	from the row/column maintainers.
	update_puzzle_info: (grid, row_id, col_id, cage_id, fresh_val) ->
		selective_reduction = false

		if row_id is -1 or col_id is -1
			selective_reduction = true

		if row_id isnt -1
			grid.update_row( row_id, fresh_val )
			for sq in grid.display[row_id]
				cage = (cage for cage in grid.cages when cage.id is sq.cage_id)[0]
				if cage?
					if selective_reduction
						if cage.id is cage_id
							continue

					cand_index = 0
					for i in [0...cage.location.length]
						if cage.location[i] is sq
							cand_index = i

					to_remove = []
					for candidate in cage.candidates
						if candidate[cand_index] is fresh_val
							to_remove.push candidate
					for rem_info in to_remove
						cage.candidates = @remove(cage.candidates, rem_info)

		if col_id isnt -1
			grid.update_column( col_id, fresh_val )

			for i in [0...grid.size]
				sq = grid.display[i][col_id]
				cage = (cage for cage in grid.cages when cage.id is sq.cage_id)[0]
				if cage?
					if selective_reduction
						if cage.id is cage_id
							continue

					cand_index = 0
					for j in [0...cage.location.length]
						if cage.location[j] is sq
							cand_index = j

					to_remove = []
					for candidate in cage.candidates
						if candidate[cand_index] is fresh_val
							to_remove.push candidate
					for rem_info in to_remove
						cage.candidates = @remove(cage.candidates, rem_info)

		return grid

	# ### Solver.clone( obj )
	# Deep clone of an object.
	# ### Parameters
	# * `obj' - the object to be cloned.
	clone: (obj) ->
		if not obj? or typeof obj isnt 'object'
			return obj

		newInstance = new obj.constructor()

		for key of obj
			newInstance[key] = @clone obj[key]

		return newInstance

	# ### Solver.remove( arr, val )
	# Returns array arr, with value val removed
	# ### Parameters
	# * `arr' - array from which we want to remove a value.
	# * `val' - value we wish to remove from arr.
	remove: (arr, val) ->
		x for x in arr when x!=val


this.Solver = Solver