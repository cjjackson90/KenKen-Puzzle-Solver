class Solver
	
	current_puzzle: null
	solution_order: []
	strat: null
	
	constructor: () ->
		@strat = new Strategies()
		
	solve: (grid, depth) ->
		# console.log grid


		grid_complete = true
		for i in [0...grid.size]
			for j in [0...grid.size]
				if grid.display[i][j].value is null
					grid_complete = false
					break

		verified_correct = grid.verify_correct()
		# console.log "verified_correct.status = #{verified_correct.status}"

		if verified_correct.status is "valid"
			return_obj =
				status: "valid"
				valid_grid: grid
			return return_obj

		if verified_correct.status is "inconsistent"
			return_obj = 
				status: "invalid"
			return return_obj


		# if verified_correct is false and grid_complete is true
		# 	return_obj =
		# 		status:"invalid"
		# 	return return_obj

		# if verified_correct is true
		# 	return_obj = 
		# 		status:"valid"
		# 		valid_grid: grid
		# 	return return_obj
		
		if grid.cages_have_candidates( ) is false
			return_obj = 
				status:"invalid"
			return return_obj


		# TODO: Implement strategies.
		test = @strat.one_candidate( grid )
		# console.log "test.status = #{test.status}"
		# console.log test.vals

		# console.log "grid.display after strategy"
		# console.log "#{grid.display[0][0].value}, #{grid.display[0][1].value}, #{grid.display[0][2].value}, #{grid.display[0][3].value}"
		# console.log "#{grid.display[1][0].value}, #{grid.display[1][1].value}, #{grid.display[1][2].value}, #{grid.display[1][3].value}"
		# console.log "#{grid.display[2][0].value}, #{grid.display[2][1].value}, #{grid.display[2][2].value}, #{grid.display[2][3].value}"
		# console.log "#{grid.display[3][0].value}, #{grid.display[3][1].value}, #{grid.display[3][2].value}, #{grid.display[3][3].value}"

		# console.log "C2 = #{grid.display[2][1].value}"
		# console.log "C3 = #{grid.display[2][2].value}"
		# console.log "D3 = #{grid.display[3][2].value}"
		# console.log "D4 = #{grid.display[3][3].value}"

		




		# console.log "grid.display[2][0].cage_id = #{grid.display[2][0].cage_id}"
		# for cage in grid.cages
		# 	console.log cage.id
		# 	if cage.id is grid.display[2][0].cage_id
		# 		this_cage = cage
		# 		console.log "MATCH"
		
		# console.log "this_cage"
		# console.log this_cage
		# this_cage = (cage for cage in grid.cages when cage.id is grid.display[0][0].cage_id)

		if test.status is true
			for sq in test.vals
				temp = @update_puzzle_info( grid, sq )
				grid = temp
			# console.log "2nd set of 1-cand squares"
			# console.log "A1 = #{grid.display[0][0].value}"
			# console.log "C2 = #{grid.display[2][1].value}"
			# console.log "C3 = #{grid.display[2][2].value}"
			# console.log "D3 = #{grid.display[3][2].value}"
			# console.log "D4 = #{grid.display[3][3].value}"

			# if test.status is true
			
			return_obj = @solve(grid, depth+1)
			console.log "post_update, #{depth}: #{return_obj.status}"
			switch return_obj.status
				when "valid"
					return return_obj
				when "invalid"
					return {status:"invalid"}
		


		# console.log "A1 GOING INTO POTENT = #{grid.display[0][0].value}"
		# console.log "this_cage"
		# console.log this_cage
		# if this_cage.length is 1
		# 	this_cage[0].add_candidate_to_grid([4])
		# # grid.add_candidate(grid.display[2][0], [1])
		# 	console.log grid.cages[0].candidates
		# 	console.log "Updating puzzle info..."
		# 	temp = @update_puzzle_info(grid, grid.display[0][0])
		# 	grid = temp
		# 	console.log "grid.cages[0]"
		# 	console.log grid.cages[0].candidates
		# if test is true
		# 	# console.log "huh?"
		# 	return_obj =
		# 		status:"debug"
		# 		grid: grid				

		potentials = @get_potentials(grid)
		# console.log "potentials"
		# console.log potentials
		# console.log "potentials[0].display[0][0].value"
		# console.log potentials[0].display[0][0].value
		# for i in [0...potentials.length]
		# 	for cage in potentials[i].cages
		# 		if cage.location[0]? and cage.location[1]? and cage.location[2]?
		# 			console.log "A2 = #{cage.location[0].value}, B2 = #{cage.location[1].value}, B3 = #{cage.location[2].value}"
		# 			if cage.location[0].value is 2 and cage.location[1].value is 3 and cage.location[2].value is 2
		# 				console.log "************232 exists!"
		# if potentials.length is 1
		# 	return_obj =
		# 		status:"update"
		# 		updated_grid: potentials[0]
		# 	return return_obj

		# console.log "potentials 2"
		# console.log potentials
		for new_grid in potentials
			return_obj = @solve( new_grid, depth+1 )
			# console.log "potentials return_obj ="
			# console.log return_obj
			# console.log "potentials"
			# console.log potentials
			switch return_obj.status
				when "update"
					return return_obj
				when "valid"
					return return_obj

			# console.log "Returned to here. Following grid invalid."
			# console.log "A1 = #{new_grid.display[0][0].value}, A2 = #{new_grid.display[0][1].value}, A3 = #{new_grid.display[0][2].value}, A4 = #{new_grid.display[0][3].value}"
			# console.log "B1 = #{new_grid.display[1][0].value}, B2 = #{new_grid.display[1][1].value}, B3 = #{new_grid.display[1][2].value}, B4 = #{new_grid.display[1][3].value}"
			# console.log "C1 = #{new_grid.display[2][0].value}, C2 = #{new_grid.display[2][1].value}, C3 = #{new_grid.display[2][2].value}, C4 = #{new_grid.display[2][3].value}"
			# console.log "D1 = #{new_grid.display[3][0].value}, D2 = #{new_grid.display[3][1].value}, D3 = #{new_grid.display[3][2].value}, D4 = #{new_grid.display[3][3].value}"
				# when "invalid"
				# 	break
		return {status:"invalid"}			



	# 	if @backtrack(grid) is "invalid"
	# 		return {status:"invalid"}
	# 	else
	# 		return {status:"update"}

	get_potentials: (grid) ->
		# console.log "In get_potentials..."
		profitable_cage = null # Chose some method of selecting a profitable cage for backtracking.
		potentials = []
		# console.log "grid.A1 = #{grid.display[0][0].value}"
		smallest_cage = grid.cages[0]
		# console.log "initial smallest_cage"
		# console.log smallest_cage
		first_index = 0

		for i in [0...grid.cages.length]
			# console.log grid.cages[i].location
			viable_cage = false
			for sq in grid.cages[i].location
				if sq.value is null
					# console.log sq
					# console.log "sq.value = #{sq.value}"
					viable_cage = true
					break
			if viable_cage is true
				smallest_cage = grid.cages[i]
				first_index = i
				# console.log "first_index = #{first_index}"
				break

		# console.log "smallest_cage"
		# console.log smallest_cage
		# smallest_cage = grid.cages[0]
		# for square in grid.cages[0]
			# if not square.value?
				# viable = true
				# break

		# for candidate in smallest_cage.candidates
		smallest_length = smallest_cage.candidates.length
		# console.log "smallest_length = #{smallest_length}"
		# console.log "smallest_length = #{smallest_length}"
		# for cand_group, candidate of smallest_cage.candidates
		# 	smallest_length = candidate.length
			# console.log smallest_length

		# console.log "deffo here..."
		# console.log first_index+1
		# console.log grid.cages[first_index+1]
		# console.log "grid.A1 = #{grid.display[0][0].value}"
		for cage in grid.cages[first_index+1...grid.cages.length]
			# console.log "reaching??"
			# console.log cage
			# console.log "cage.candidates"
			# console.log cage.candidates
			viable = false
			if cage.candidates.length isnt 0
				for square in cage.location
					# console.log "square.value = #{square.value}. this should be null..."
					if square.value is null
						viable = true
						break

			# console.log "cage.candidates.length = #{cage.candidates.length}, viable=#{viable}"
			if cage.candidates.length < smallest_length and viable
				# console.log "updating smallest_cage to"
				# console.log cage
				smallest_cage = cage
				smallest_length = cage.candidates.length
			# for cand_group, candidate of cage.candidates
			# 	# console.log "candidate.length = #{candidate.length}, smallest_length = #{smallest_length}, viable?=#{viable}"
			# 	if candidate.length < smallest_length and viable is true
			# 		smallest_cage = cage
			# 		smallest_length = candidate.length
		# console.log "profitable_cage"
		profitable_cage = smallest_cage #grid.cages[0] #smallest_cage
		# console.log "smallest_cage.candidates"
		# console.log smallest_cage.candidates
		# console.log "profitable_cage"
		# console.log profitable_cage
		# Populate potentials

		# console.log "grid.A1 (before potentials made) = #{grid.display[0][0].value}"
		for candidate in profitable_cage.candidates
			# temp = new Grid (grid.size)
			# jQuery.extend(true, temp, grid)
			temp = @clone ( grid )
			# console.log "temp"
			# console.log temp
			# console.log "temp.A1 = #{temp.display[0][0].value}"
			for cage in temp.cages
				for i in [0...cage.location.length]
					cage.location[i] = temp.get_square( cage.location[i].id )
				if cage.id is profitable_cage.id
					temp.add_candidate cage.location, candidate
			potentials.push @clone temp

		potentials
		# for cand_group, cand of profitable_cage.candidates
		# 	for candidate in cand
		# 		# console.log candidate
		# 		temp = new Grid (grid.size)
		# 		jQuery.extend(true, temp, grid) #@clone(grid)
		# 		# temp = @clone(grid)
		# 		# temp = grid
		# 		for cage in temp.cages
		# 			for i in [0...cage.location.length]
		# 				# console.log cage.location[i]
		# 				# console.log temp.get_square(cage.location[i].id)
		# 				cage.location[i] = temp.get_square(cage.location[i].id)
		# 			if cage.id is profitable_cage.id
		# 				# console.log "updating square"
		# 				temp.add_candidate cage.location, candidate
		# 				# cage.add_candidate_to_grid candidate
		# 		# console.log "Temp is here"
		# 		# console.log temp
		# 		# console.log temp.cages
		# 		potentials.push @clone temp
		# 		temp = null


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

	update_puzzle_info: (grid, new_square) ->
		rows = grid.rows
		cols = grid.cols

		# console.log "new_square"
		# console.log new_square

		row_id = new_square.row_id
		col_id = new_square.col_id

		# console.log "sq in grid.display[row_id]"
		for sq in grid.display[row_id]
			# console.log sq
			cage = (cage for cage in grid.cages when cage.id is sq.cage_id)[0]
			if cage?
				# console.log "original cage"
				# console.log cage
				cand_index = 0
				for i in [0...cage.location.length]
					if cage.location[i] is sq
						cand_index = i

				to_remove = []
				for candidate in cage.candidates
					if candidate[cand_index] is new_square.value
						to_remove.push candidate
				for rem_info in to_remove
					cage.candidates = @remove(cage.candidates, rem_info)

		return grid
				# for cand_group, cand of cage.candidates
				# 	for candidate in cand
				# 		# console.log "candidate"
				# 		# console.log candidate
				# 	# console.log "candidate[cand_index]"
				# 	# console.log candidate[cand_index]
				# 	# console.log "candidate[cand_index] is sq.value = #{candidate[cand_index] is sq.value}"
				# 		if candidate?
				# 			if candidate[cand_index] is new_square.value
				# 			# console.log "cand"
				# 			# console.log cand
				# 			# console.log "candidate"
				# 			# console.log candidate
							
				# 			# to_remove.push candidate
				# 				cand = @remove(cand, candidate)

				# 			# test = @remove(cand, candidate)
				# 			# console.log "removed vals"
				# 			# console.log test
				# 			# cand = test
				# 	# console.log "to_remove"
				# 	# console.log to_remove
				# # for rem_info in to_remove
				# # 	cand = @remove(cand, rem_val)

			# console.log "updated cage"
			# console.log cage

		# console.log "Exiting update..."

			# console.log "TEST TEST TEST"
			# for cand_group, cand of cage.candidates
			# 	console.log "cand_group"
			# 	console.log cand_group
			# 	console.log "cand"
			# 	console.log cand
			# 	for candidate in cand
			# 		console.log "candidate"
			# 		console.log candidate


			# for cand_group, cand of sq
			# 	if sq.


		# for updated_sq in new_square
		# 	# check affected row
		# 	row_id = updated_sq.row_id
		# 	console.log "updated_sq.id = #{updated_sq.id}"
		# 	for i, j of grid.display
		# 		console.log "i = #{i}, j = #{j}"
		# 	# for sq in grid.display[row_id][]
		# 		# console.log sq

		# 	# check affected column
		# 	col_id = sq.column_id

	clone: (obj) ->
		if not obj? or typeof obj isnt 'object'
			return obj

		newInstance = new obj.constructor()

		for key of obj
			newInstance[key] = @clone obj[key]

		return newInstance

	remove: (arr, val) ->
		x for x in arr when x!=val

	# remove: () ->

this.Solver = Solver