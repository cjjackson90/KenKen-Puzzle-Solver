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
		@candidates = []
		switch @operation
			when "+"
				#console.log "******NEW + ********"
				##console.log @target
				for i in [@grid_size..1]
					single_candidate = []
					single_candidate.push i
				##console.log single_candidate
				#single_candidate.push 4
					@bt_plus single_candidate, 1
				#console.log "location.length = #{@location.length}, candidates="
				#console.log @candidates
				break
			when "-" #then @candidates_minus grid_size
				#console.log "********* minus"
				for i in [@grid_size..1]
					single_candidate = []
					single_candidate.push i
					@bt_minus single_candidate, 1
				break
			when "*" #then @candidates_multi(grid_size)
				#console.log "********* multiply"
				for i in [@grid_size..1]
					single_candidate = []
					single_candidate.push i
					@bt_multi single_candidate, 1
				break
			when "/" #then @candidates_divide(grid_size)
				#console.log "/////////// divide"
				for i in [@grid_size..1]
					single_candidate = []
					single_candidate.push i
					@bt_divide single_candidate, 1

	bt_plus: (candidate, counter) ->
		running_target = @target
		#######console.log "candidate =  #{candidate}, counter = #{counter}"
		##console.log candidate
		for prev_vals in [0...candidate.length]
			running_target -= candidate[prev_vals]
		##console.log running_target

		if running_target < 0 or (running_target is 0 and counter isnt @location.length)
			##console.log "invalid"
			return #candidate.pop()
		
		if running_target is 0
			#console.log "######valid"
			#console.log "targetop = #{@target}#{@operation}"
			#console.log "check_consistent() = #{candidate}"
			if @check_consistent(candidate) is true
				console.log "Candidate added!"
				@candidates.push candidate[0..candidate.length]
			return
			
		if counter >= (@location.length)
			##console.log "invalid 2"
			return

		##console.log "Hello?"
		##console.log @location.length
		potentials = [@grid_size..1]
		for val in potentials
			
			new_branch = candidate
			new_branch.push val
			new_count = counter+1
			##console.log "the candidate entering bt() is #{candidate}"
			@bt_plus new_branch, new_count
			candidate.pop()


			#for i in [4..1]
			#	temp = new_branch
			#	temp.push i
			#	@bt_plus temp, ++counter

	bt_minus: (candidate, counter) ->
		running_target = candidate[0]
		##console.log "candidate =  #{candidate}, counter = #{counter}"
		##console.log candidate
		for prev_vals in [1...candidate.length]
			running_target -= candidate[prev_vals]
		# #console.log "running target #{running_target}"

		if running_target < @target or (running_target is @target and counter isnt @location.length)
			# #console.log "invalid"
			return #candidate.pop()
		
		if running_target is @target
			# #console.log "######valid"
			# #console.log "valid candidate = #{candidate}"
			# #console.log candidate[0...candidate.length]
			if (@check_consistent(candidate) is true)
				console.log "Candidate added!"
				@candidates.push candidate[0..candidate.length]
			return
		##console.log "location.length = #{@location.length}, counter=#{counter}"
		if counter >= (@location.length)
			# #console.log "invalid 2"
			return

		##console.log "Hello?"
		##console.log @location.length
		potentials = [@grid_size..1]
		for val in potentials
			new_branch = candidate
			new_branch.push val
			new_count = counter+1
			# #console.log "the candidate entering bt() is #{candidate}"
			@bt_minus new_branch, new_count
			candidate.pop()

	bt_multi: (candidate, counter) ->
		running_target = candidate[0]
		#console.log "candidate =  #{candidate}, counter = #{counter}"
		##console.log candidate
		for prev_vals in [1...candidate.length]
			running_target *= candidate[prev_vals]
		##console.log running_target

		if running_target > @target or (running_target is @target and counter isnt @location.length)
			#console.log "invalid"
			return #candidate.pop()
		
		if running_target is @target
			#console.log "######valid"
			##console.log candidate[1..candidate.length]
			if (@check_consistent(candidate) is true)
				console.log "Candidate added!"
				@candidates.push candidate[0..candidate.length]
			return
		#console.log "location.length = #{@location.length}, counter=#{counter}"
		if counter >= (@location.length)
			#console.log "invalid 2"
			return

		##console.log "Hello?"
		##console.log @location.length
		potentials = [@grid_size..1]
		for val in potentials
			
			new_branch = candidate
			new_branch.push val
			new_count = counter+1
			#console.log "the candidate entering bt() is #{candidate}"
			@bt_multi new_branch, new_count
			candidate.pop()


			#for i in [4..1]
			#	temp = new_branch
			#	temp.push i
			#	@bt_plus temp, ++counter

	bt_divide: (candidate, counter) ->
		running_target = candidate[0]
		#console.log "candidate =  #{candidate}, counter = #{counter}"
		# #console.log candidate
		for prev_vals in [1...candidate.length]
			running_target /= candidate[prev_vals]
		#console.log running_target

		if running_target < @target
			#console.log "invalid"
			return #candidate.pop()
		
		if running_target is @target
			#console.log "######valid"
			if counter isnt @location.length
				i = @location.length
				#console.log "location.length = #{@location.length}, #{i}, #{counter}"
				while i isnt counter
					candidate.push 1
					i--
				#console.log "candidate = #{candidate}"
			##console.log candidate[1..candidate.length]
			if (@check_consistent(candidate) is true)
				console.log "Candidate added!"
				@candidates.push candidate[0..candidate.length]
			return
		#console.log "location.length = #{@location.length}, counter=#{counter}"
		if counter >= (@location.length)
			#console.log "invalid 2"
			return

		##console.log "Hello?"
		##console.log @location.length
		potentials = [@grid_size..1]
		for val in potentials
			
			new_branch = candidate
			new_branch.push val
			new_count = counter+1
			#console.log "the candidate entering bt() is #{candidate}"
			@bt_divide new_branch, new_count
			candidate.pop()


			#for i in [4..1]
			#	temp = new_branch
			#	temp.push i
			#	@bt_plus temp, ++counter

	check_consistent: (candidate) ->
		#console.log "candidate=#{candidate}"
		if candidate.length is 1
			return true
		else
			for i in [0...candidate.length]
				row = @location[i].row_id_char
				col = @location[i].column_id+1
				console.log "row=#{row}, col=#{col}"
				for j in [i+1...candidate.length]
					if not candidate[j]?
						break
					cmp_row = @location[j].row_id_char
					cmp_col = @location[j].column_id+1
					console.log "   cmp_row=#{cmp_row}, cmp_col=#{cmp_col}"
					if cmp_row is row or cmp_col is col
						console.log "      candidate[i]=#{candidate[i]}, candidate[j]=#{candidate[j]}"
						if candidate[i] is candidate[j]
							console.log "      ERROR: inconsistent"
							return false
						else
							console.log "      Consistent"
							#@candidates.push candidate[0..candidate.length]
							#return true
			return true
			

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