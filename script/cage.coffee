class Cage

	# ID of the cage - unique random val.
	id: null

	# The value this cage must reach using operation.
	target: null

	# The operation used to reach the target when
	# combining cage values. Either "+", "-", "*" or "/"
	operation: null

	# Array of squares which this cage consists of.
	location: []

	# values which can potentially populate the squares
	# in this cage.
	candidates: []

	# size of the grid this cage belongs to.
	grid_size: null

	# ### Cage.constructor( )
	# Initialises a cage. Requires location as an array
	# of squares from the grid.
	# ### Parameters
	# * `location' - array of squares giving cage location.
	constructor: (location) ->
		@id = uniqueId( )
		@location = location

	# ### Cage.update_square_cage_ids( )
	# Goes through all the squares that make this cage and
	# update their cage_id reference to the id of this cage.
	# ### Parameters
	update_square_cage_ids: () ->
		for square in @location
			square.set_cage_id @id
			# console.log square

	# ### Cage.update_target( )
	# Updates the target value of this cage.
	# ### Parameters
	# * `target' - value this cage needs to reach
	update_target: (@target) ->

	# ### Cage.update_operation( )
	# Update the mathematical operator which will be used
	# on the cages' values to try to reach the target val.
	# ### Parameters
	# * `operation' - string value of "+", "-", "x" or "/"
	update_operation: (@operation) ->

	# ### Cage.find_all_candidates ( )
	# Method called externally to find all the valid
	# candidates of this cage.
	# ### Parameters
	# * `grid_size' - used to calculate the valid combinations
	#	for candidates.
	find_all_candidates: (grid_size) ->
		@grid_size = grid_size
		output = ""
		@candidates = []
		switch @operation
			when "+"
				for i in [@grid_size..1]
					single_candidate = []
					single_candidate.push i
					@bt_plus single_candidate, 1
				break
			when "-"
				for i in [@grid_size..1]
					single_candidate = []
					single_candidate.push i
					@bt_minus single_candidate, 1
				break
			when "*"
				for i in [@grid_size..1]
					single_candidate = []
					single_candidate.push i
					@bt_multi single_candidate, 1
				break
			when "/"
				for i in [@grid_size..1]
					single_candidate = []
					single_candidate.push i
					@bt_divide single_candidate, 1

	# ### Cage.bt_plus ( )
	# Backtracking method for finding all candidates if the cage
	# has a plus operator. Called by find_all_candidates( )
	# ### Parameters
	# * `candidate' - current potential candidate. Number of values
	#	in candidate grows with each recursive call until cage size
	#	is filled.
	# * `counter' - used to check depth of recursive call.
	bt_plus: (candidate, counter) ->
		running_target = @target

		if candidate[0]*@location.length < @target
			return
		if candidate[0]+@location.length-1 > @target
			return

		for prev_vals in [0...candidate.length]
			running_target -= candidate[prev_vals]

		if running_target < 0 or (running_target is 0 and counter isnt @location.length)
			return
		
		if running_target is 0			
			perms = permute candidate, @grid_size
			for permutation in perms
				if @check_consistent( permutation )
					@candidates.push permutation
			new_candidates = @unique @candidates

			@candidates = new_candidates

			return
			
		if counter >= (@location.length)
			return

		n = if candidate[candidate.length-1] < @grid_size then candidate[candidate.length-1] else @grid_size

		no_solutions = 1
		potentials = [n..1]
		for val in potentials
			new_branch = candidate
			new_branch.push val
			new_count = counter+1
			@bt_plus new_branch, new_count
			candidate.pop()

		return

	# ### Cage.bt_minus ( )
	# Backtracking method for finding all candidates if the cage
	# has a minus operator. Called by find_all_candidates( )
	# ### Parameters
	# * `candidate' - current potential candidate. Number of values
	#	in candidate grows with each recursive call until cage size
	#	is filled.
	# * `counter' - used to check depth of recursive call.
	bt_minus: (candidate, counter) ->
		running_target = candidate[0]

		if candidate[0] < @target
			return

		for prev_vals in [1...candidate.length]
			running_target -= candidate[prev_vals]

		if running_target < @target or (running_target is @target and counter isnt @location.length)
			return
		
		if running_target is @target
			perms = permute candidate, @grid_size
			for permutation in perms
				if @check_consistent( permutation )
					@candidates.push permutation

			new_candidates = (@unique( @candidates ))
			@candidates = new_candidates

			return

		if counter >= (@location.length)
			return

		n = if candidate[candidate.length-1] < @grid_size then candidate[candidate.length-1] else @grid_size
		potentials = [n..1]
		for val in potentials
			new_branch = candidate
			new_branch.push val
			new_count = counter+1
			@bt_minus new_branch, new_count
			candidate.pop()

	# ### Cage.bt_multi ( )
	# Backtracking method for finding all candidates if the cage
	# has a multiplication operator. Called by find_all_candidates( )
	# ### Parameters
	# * `candidate' - current potential candidate. Number of values
	#	in candidate grows with each recursive call until cage size
	#	is filled.
	# * `counter' - used to check depth of recursive call.
	bt_multi: (candidate, counter) ->
		running_target = candidate[0]
		for prev_vals in [1...candidate.length]
			running_target *= candidate[prev_vals]

		if running_target > @target or candidate.length > @location.length
			return 1
		
		if running_target is @target
			pop_counter = 1
			if counter isnt @location.length
				i = @location.length
				while i isnt counter
					candidate.push 1
					i--
					++pop_counter
			perms = permute candidate, @grid_size
			for permutation in perms
				if @check_consistent( permutation )
					@candidates.push permutation


			new_candidates = @unique @candidates
			@candidates = new_candidates

			return pop_counter
		if counter >= (@location.length)
			return 1

		n = if candidate[candidate.length-1] < @grid_size then candidate[candidate.length-1] else @grid_size
		potentials = [n..2]
		for val in potentials
			new_branch = candidate
			new_branch.push val
			new_count = counter+1
			k = @bt_multi new_branch, new_count
			while k isnt 0
				candidate.pop()
				k--
		return 1

	# ### Cage.bt_divide( candidate, counter )
	# Backtracking method for finding all candidates if the cage
	# has a divide operator. Called by find_all_candidates( )
	# ### Parameters
	# * `candidate' - current potential candidate. Number of values
	#	in candidate grows with each recursive call until cage size
	#	is filled.
	# * `counter' - used to check depth of recursive call.
	bt_divide: (candidate, counter) ->
		running_target = candidate[0]
		for prev_vals in [1...candidate.length]
			running_target /= candidate[prev_vals]

		if running_target < @target
			return
		
		if running_target is @target
			if counter isnt @location.length
				i = @location.length
				while i isnt counter
					candidate.push 1
					i--
			perms = permute candidate, @grid_size
			for permutation in perms
				@candidates.push permutation


			new_candidates = @unique @candidates
			@candidates = new_candidates
			return

		if counter >= (@location.length)
			return

		n = if candidate[candidate.length-1] < @grid_size then candidate[candidate.length-1] else @grid_size
		potentials = [n..1]
		for val in potentials
			
			new_branch = candidate
			new_branch.push val
			new_count = counter+1
			@bt_divide new_branch, new_count
			candidate.pop()

	# ### Cage.check_consistent( candidate )
	# Returns true or false depending on if the candidate is
	# consistent or not, ie, no duplicated values in a row/col.
	check_consistent: (candidate) ->
		if candidate.length is 1
			return true
		else
			for i in [0...candidate.length]
				row = @location[i].row_id_char
				col = @location[i].column_id+1
				for j in [i+1...candidate.length]
					if not candidate[j]?
						break
					cmp_row = @location[j].row_id_char
					cmp_col = @location[j].column_id+1
					if cmp_row is row or cmp_col is col
						if candidate[i] is candidate[j]
							return false
						else
			return true
	
	# ### Cage.add_candidate_to_grid( candidate )
	# Sets the square (grid) values to be the candidate.		
	add_candidate_to_grid: (candidate) ->
		for i in [0...@location.length]
			@location[i].set_value candidate[i]


	# The following two functions for finding a permutation were taken from
	# http://rosettacode.org/wiki/Permutations#CoffeeScript

	# Returns a copy of an array with the element at a specific position
	# removed from it.
	arrayExcept = (arr, idx) ->
		res = arr[0..]
		res.splice idx, 1
		res
	 
	# The actual function which returns the permutations of an array-like
	# object (or a proper array).
	permute = (arr, grid_size) ->
		arr = Array::slice.call arr, 0
		return [[]] if arr.length == 0
	 
		permutations = (for value,idx in arr
			[value].concat perm for perm in permute arrayExcept arr, idx)


		# Flatten the array before returning it.
		[].concat permutations...

	# ### Cage.unique( array )
	# Returns copy of array, without duplicated values. Duplicated vals
	# can exist due to multiple uses of a number in a cage.
	unique: (array) ->
		output = {}
		output[array[key]] = array[key] for key in [0...array.length]
		value for key, value of output

this.Cage = Cage