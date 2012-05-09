class Strategies

	# ### Strategies.constructor()
	# Initialises instance of strategies class.
	constructor: () ->

	# ### Strategies.one_candidate( grid )
	# Finds cages which have only one candidate (ie, candidate is
	# only possible entry for the cage) and returns an object
	# containing status of the strategy's success (true, false),
	# values that have only one candidate (if applicable) and the
	# updated grid.
	# ### Parameters
	# * `grid' - the grid instance we wish to search for single
	#	candidate cages.
	one_candidate: (grid) ->
		vals_added = false
		vals = []
		new_grid = grid
		for cage in new_grid.cages
			if cage.candidates.length is 1
				valid = false
				for sq in cage.location
					if sq.value is null
						valid = true
						break
				if valid
					cage.add_candidate_to_grid( cage.candidates[0] )
					for sq in cage.location
						vals.push sq
					vals_added = true
		return_obj =
			status: vals_added
			vals: vals
			grid: new_grid
		return return_obj

	# ### Strategies.common_numbers( grid )
	# Finds cages which have a `common number' in their candidates, ie,
	# a value which appears in every candidate for that cage. As the
	# value is thus accounted for the candidates of the remaining cages
	# can be updated. This also returns an object containing status
	# of the strategy's success (true, false), values that have only
	# one candidate (if applicable) and the updated grid. 
	# ### Parameters
	# * `grid' - the grid instance we wish to search for candidates
	#	containing common numbers..
	common_numbers: (grid) ->
		for cage in grid.cages
			if cage.candidates.length is 0
				continue
			if cage.candidates[0].length > grid.size
				continue

			same_row = true
			same_col = true
			row_id = cage.location[0].row_id
			col_id = cage.location[0].column_id

			for sq in cage.location
				if sq.row_id isnt row_id
					same_row = false
				if sq.col_id isnt col_id
					same_col = false

				if same_row is false and same_col is false
					return_obj =
						status:false

			if same_row
				potentials = cage.candidates[0]

				temp = []
				for val in potentials
					if grid.rows[row_id][val-1] is null
						temp.push @remove( potentials, val )

				for val in temp
					foo = @remove( potentials, val[0] )
					potentials = foo

				if potentials.length is 0
					continue

				for candidate in cage.candidates[1...cage.candidates.length]
					for val in potentials
						if (included = val in candidate) is false
							potentials = @remove( potentials, val )


				if potentials.length > 0
					output = []
					for val in potentials
						rem_obj =
							row_or_col:"row"
							id: row_id
							cage_id: cage.id
							val:  val
						output.push rem_obj
				return_obj =
					status: potentials.length > 0
					vals: output
					grid: grid
				return return_obj


			if same_col
				potentials = cage.candidates[0]
				temp = []
				for val in potentials
					if grid.columns[col_id][val-1] is null
						temp.push @remove( potentials, val )

				for val in temp
					foo = @remove( potentials, val[0] )
					potentials = foo

				if potentials.length is 0
					continue

				for candidate in cage.candidates[1...cage.candidates.length]
					for val in potentials
						if (included = val in candidates) is false
							potentials = @remove( potentials, val )

				if potentials.length > 0
					output = []
					for val in potentials
						rem_obj =
							row_or_col:"col"
							id: col_id
							cage_id: cage.id
							val: val
						output.push rem_obj
				return_obj =
					status: potentials.length > 0
					vals: output
					grid: grid
				return return_obj

		return_obj = 
			status:"debug"
			grid:grid
		return return_obj

	certain_vals: (grid) ->
		return false

	remove: (arr, val) ->
		x for x in arr when x!=val

this.Strategies = Strategies