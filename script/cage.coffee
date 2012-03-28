class Cage
	
	id: null
	target: null
	operation: null
	location: []
	candidates: []
	grid_size: null


	constructor: (location) ->
		@location = location
		@id = uniqueId( )
	
	update_target: (target) ->
		@target = target

	update_operation: (op) ->
		@operation = op

	find_all_candidates: (grid_size) ->
		
		#TODO: optimise by reducing from brute force.
		@grid_size = grid_size
		output = ""

		switch @operation
			when "+"
				#console.log @target
				single_candidate = []
				single_candidate.push 7
				#console.log single_candidate
				#single_candidate.push 4
				@bt_plus single_candidate, 0
				#console.log @candidates
			when "-" then @candidates_minus(grid_size)
			when "*" then @candidates_multi(grid_size)
			when "/" then @candidates_divide(grid_size)

	bt_plus: (candidate, counter) ->
		running_target = candidate[0]
		console.log "candidate =  #{candidate}, counter = #{counter}"
		#console.log candidate
		for prev_vals in [1...candidate.length]
			running_target -= candidate[prev_vals]
		console.log running_target

		if running_target < 0 or (running_target is 0 and counter isnt @location.length)
			console.log "invalid"
			return #candidate.pop()
		if running_target is 0
			console.log "######valid"
			console.log candidate[1..candidate.length]
			@candidates.push candidate[1..candidate.length]
			return
		#console.log "Hello?"
		#console.log @location.length
		potentials = [2..1]
		for val in potentials
			
			new_branch = candidate
			new_branch.push val
			console.log "the candidate entering bt() is #{candidate}"
			@bt_plus new_branch, ++counter
			candidate.pop()


			#for i in [4..1]
			#	temp = new_branch
			#	temp.push i
			#	@bt_plus temp, ++counter



	candidates_plus: (n, output) ->
		console.log n
		if (n <= 0) and (output.length < @grid_size)
			return null
		else if (n is 0)
			return output
		else
			current =  if n > @grid_size then @grid_size else n
			console.log current
			while current > 0
				#output += current
				console.log output
				temp = @candidates_plus n-current, output
				current-- 
			  # body...





		#while(running_target > 0)




	candidates_minus: (grid_size) ->

	candidates_multi: (grid_size) ->

	candidates_divide: (grid_size) ->

	add_candidate_to_grid: (candidate) ->
	



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

this.Cage = Cage