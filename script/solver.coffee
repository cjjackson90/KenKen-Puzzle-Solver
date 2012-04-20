class Solver
	
	current_puzzle: null
	solution_order: []
	
	constructor: () ->
		
	solve: (grid) ->
		# console.log grid
		grid_complete = true
		for i in [0...grid.size]
			for j in [0...grid.size]
				if grid.display[i][j].value is null
					grid_complete = false
					break

		verified_correct = grid.verify_correct()

		if verified_correct is false and grid_complete is true
			return_obj =
				status:"invalid"
			return return_obj

		if verified_correct is true
			return_obj = 
				status:"valid"
				valid_grid: grid
			return return_obj
		
		if grid.cages_have_candidates( ) is false
			return_obj = 
				status:"invalid"
			return return_obj


		# TODO: Implement strategies.

		potentials = @get_potentials(grid)
		console.log "potentials"
		console.log potentials
		for i in [0...potentials.length]
			for cage in potentials[i].cages
				if cage.location[0]? and cage.location[1]? and cage.location[2]?
					console.log "A2 = #{cage.location[0].value}, B2 = #{cage.location[1].value}, B3 = #{cage.location[2].value}"
					if cage.location[0].value is 2 and cage.location[1].value is 3 and cage.location[2].value is 2
						console.log "************232 exists!"
		if potentials.length is 1
			return_obj =
				status:"update"
				updated_grid: potentials[0]
			return return_obj

		console.log "potentials 2"
		console.log potentials
		for new_grid in potentials
			return_obj = @solve(new_grid)

			switch return_obj.status
				when "update"
					return return_obj
				when "valid"
					return return_obj

			console.log "Returned to here. Following grid invalid."
			console.log new_grid
				# when "invalid"
				# 	break
		return {status:"invalid"}			



	# 	if @backtrack(grid) is "invalid"
	# 		return {status:"invalid"}
	# 	else
	# 		return {status:"update"}

	get_potentials: (grid) ->
		profitable_cage = null # Chose some method of selecting a profitable cage for backtracking.
		potentials = []

		smallest_cage = grid.cages[0]
		first_index = 0

		for i in [0...grid.cages.length]
			# console.log grid.cages[i].location
			viable_cage = false
			for sq in grid.cages[i].location
				if sq.value is null
					viable_cage = true
					break
			if viable_cage is true
				smallest_cage = grid.cages[i]
				first_index = i
				# console.log "first_index = #{first_index}"
				break

		console.log "smallest_cage"
		console.log smallest_cage
		# smallest_cage = grid.cages[0]
		# for square in grid.cages[0]
			# if not square.value?
				# viable = true
				# break

		for cand_group, candidate of smallest_cage.candidates
			smallest_length = candidate.length
			console.log smallest_length

		# console.log "deffo here..."
		# console.log first_index+1
		# console.log grid.cages[first_index+1]
		for cage in grid.cages[first_index+1...grid.cages.length]
			# console.log "reaching??"
			# console.log cage
			viable = false
			for square in cage.location
				# console.log "square.value = #{square.value}. this should be null..."
				if square.value is null
					viable = true
					break

			for cand_group, candidate of cage.candidates
				# console.log "candidate.length = #{candidate.length}, smallest_length = #{smallest_length}, viable?=#{viable}"
				if candidate.length < smallest_length and viable is true
					smallest_cage = cage
					smallest_length = candidate.length
		# console.log "profitable_cage"
		profitable_cage = smallest_cage #grid.cages[0] #smallest_cage

		# console.log profitable_cage
		# Populate potentials
		for cand_group, cand of profitable_cage.candidates
			for candidate in cand
				# console.log candidate
				temp = new Grid (grid.size)
				jQuery.extend(true, temp, grid) #@clone(grid)
				# temp = @clone(grid)
				# temp = grid
				for cage in temp.cages
					for i in [0...cage.location.length]
						# console.log cage.location[i]
						# console.log temp.get_square(cage.location[i].id)
						cage.location[i] = temp.get_square(cage.location[i].id)
					if cage.id is profitable_cage.id
						# console.log "updating square"
						temp.add_candidate cage.location, candidate
						# cage.add_candidate_to_grid candidate
				# console.log "Temp is here"
				# console.log temp
				# console.log temp.cages
				potentials.push @clone temp
				temp = null


		# console.log "potentials I..."
		# console.log potentials
		potentials



	# backtrack: (grid) ->
		
	# 	for grid in potentials
	# 		#for testing use - remove every other potential
	# 		# i = 0
	# 		if potentials.length is 1
	# 			break

	# 		# grid_status = solve (grid)
	# 		if grid_status is "invalid"
	# 			# console.log grid
	# 			potentials = @remove potentials, grid
	# 			# console.log "potentials I.V"
	# 			# console.log potentials
	# 			i++
	# 		else if grid_status isnt "valid"
	# 			solve(grid)

	# 	if potentials.length is 1 then
	# 		# update ( )
	# 		# return "update"
	# 	else
	# 		return "invalid"

	# 	# console.log "potentials II..."
	# 	# console.log potentials



	# 	# for all g in potentials
	# 		#if solve(g) = invalid
	# 			#remove g
	# 		#else if solve(g) =/= valid
	# 			#solve g

	# 		# if potentials.length is 1
	# 			#break
	# 	# if potentials.length is 1 then
	# 		#update info
	# 		#return 'update'
	# 	# else
	# 		# return 'invalid'


	# 	return "update"

	append_solution_order: (fresh_vals) ->

	update_puzzle_info: () ->

	clone: (obj) ->
		if not obj? or typeof obj isnt 'object'
			return obj

		newInstance = new obj.constructor()

		for key of obj
			newInstance[key] = @clone obj[key]

		return newInstance

	remove: (arr, val) ->
		x for x in arr when x!=val

this.Solver = Solver