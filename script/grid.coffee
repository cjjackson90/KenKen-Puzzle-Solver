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
	
	add_candidate: (location, candidate) ->
		# console.log candidate
		# console.log location
		for i in [0...location.length]
			current_cmp = @display[location[i].row_id][location[i].column_id]

			if current_cmp.id is location[i].id
				current_cmp.set_value candidate[i]
				row_id = current_cmp.row_id
				col_id = current_cmp.column_id
				@update_row row_id, candidate[i]
				@update_column col_id, candidate[i]

	draw: () ->

	clear: () ->

	update_row: (row_id, val) ->
		@rows[row_id][val-1] = null

	update_column: (col_id, val) ->
		@columns[col_id][val-1] = null

	update_affected_candidates: (update_type, new_sq, value) ->
		# console.log "in update_affect_candidates()"
		### update type determines whether row, column or both are
			updated. Row/Column would be updated depending on if a
			value is known to go in a particular row/column but not
			where. Both is used if the value is in place and thus
			affects both row and column.
			0 = both
			1 = row
			2 = column
		###
		switch update_type
			when 0
				affected_row = new_sq.row_id
				affected_col = new_sq.column_id

				for square in @display[affected_row]
					# console.log square
					for cage in @cages
						if cage.id is square.cage_id
							affected_cage = cage
							for i in [0...affected_cage.location.length]
								if affected_cage.location[i] is square
									loc_index = i
					# console.log "affected_cage"
					# console.log affected_cage
					# console.log "loc_index"
					# console.log loc_index
					# rem_array = []
					# rem_val = []
					for cand_group, cand of affected_cage.candidates
						# console.log "cand before removal"
						# console.log cand
						rem_array = []
						for candidate in cand
							# console.log "candidate"
							# console.log candidate
							# console.log "candidate[loc_index]"
							# console.log candidate[loc_index]
							# console.log "new_sq.value"
							# console.log new_sq.value
							if candidate[loc_index] is new_sq.value
								# console.log "removing #{candidate} from cand"
								rem_array.push candidate
						# console.log "cand post removal"
						if rem_array.length isnt 0
							# console.log "rem_array has vals..."
							# console.log rem_array
							output = affected_cage.candidates[cand_group]
							for candidate in rem_array
								# console.log "candidate in new_cand"
								# console.log candidate
								output = @remove output, candidate
								# console.log "output"
								# console.log output
							affected_cage.candidates[cand_group] = output

						# console.log "updated candidates"
						# console.log affected_cage.candidates[cand_group]
								# rem_array = cand
								# rem_val = candidate
						# console.log "rem array"
						# console.log rem_array
						# console.log "rem_val"
						# rem_array = @remove rem_array, rem_val

						# console.log "rem_array post-remove"
						# console.log rem_array
					# for i in [0...rem_array.length]
						# @remove 

				# console.log "Testy test"
				# console.log @display[0][affected_col]
				for i in [0...@size]
					square = @display[i][affected_col]
					# console.log "     checking affected column"
					# console.log square
					for cage in @cages
						if cage.id is square.cage_id
							affected_cage = cage
							for i in [0...affected_cage.location.length]
								if affected_cage.location[i] is square
									loc_index = i
					# console.log "affected_cage"
					# console.log affected_cage
					# console.log "loc_index"
					# console.log loc_index
					# rem_array = []
					# rem_val = []
					for cand_group, cand of affected_cage.candidates
						# console.log "cand before removal"
						# console.log cand
						rem_array = []
						for candidate in cand
							# console.log "candidate"
							# console.log candidate
							# console.log "candidate[loc_index]"
							# console.log candidate[loc_index]
							# console.log "new_sq.value"
							# console.log new_sq.value
							if candidate[loc_index] is new_sq.value
								# console.log "removing #{candidate} from cand"
								rem_array.push candidate
						# console.log "cand post removal"
						if rem_array.length isnt 0
							# console.log "rem_array has vals..."
							# console.log rem_array
							output = affected_cage.candidates[cand_group]
							for candidate in rem_array
								# console.log "candidate in new_cand"
								# console.log candidate
								output = @remove output, candidate
								# console.log "output"
								# console.log output
							affected_cage.candidates[cand_group] = output

						# console.log "updated candidates"
						# console.log affected_cage.candidates[cand_group]
								# rem_array = cand
								# rem_val = candidate
						# console.log "rem array"
						# console.log rem_array
						# console.log "rem_val"
						# rem_array = @remove rem_array, rem_val

						# console.log "rem_array post-remove"
						# console.log rem_array
					# for i in [0...rem_array.length]
						# @remove 

					# for cage in @cages
					# 	if cage.id is square.cage_id
					# 		affected_cage = cage
					# 		for i in [0...affected_cage.location.length]
					# 			if affected_cage.location[i] is square
					# 				loc_index = i

					# for cand_group, cand of affected_cage.candidates
					# 	for candidate in cand
					# 		if candidate[i] is new_sq.value
					# 			@remove cand, candidate 
					# 	console.log "one for every cand_group?"
			when 1
				affected_row = new_sq.row_id

				for square in @display[affected_row]
					# console.log square
					for cage in @cages
						if cage.id is square.cage_id
							affected_cage = cage
							for i in [0...affected_cage.location.length]
								if affected_cage.location[i] is square
									loc_index = i
					# console.log "affected_cage"
					# console.log affected_cage
					# console.log "loc_index"
					# console.log loc_index
					# rem_array = []
					# rem_val = []
					for cand_group, cand of affected_cage.candidates
						# console.log "cand before removal"
						# console.log cand
						rem_array = []
						for candidate in cand
							# console.log "candidate"
							# console.log candidate
							# console.log "candidate[loc_index]"
							# console.log candidate[loc_index]
							# console.log "new_sq.value"
							# console.log new_sq.value
							if candidate[loc_index] is new_sq.value
								# console.log "removing #{candidate} from cand"
								rem_array.push candidate
						# console.log "cand post removal"
						if rem_array.length isnt 0
							# console.log "rem_array has vals..."
							# console.log rem_array
							output = affected_cage.candidates[cand_group]
							for candidate in rem_array
								# console.log "candidate in new_cand"
								# console.log candidate
								output = @remove output, candidate
								# console.log "output"
								# console.log output
							affected_cage.candidates[cand_group] = output

						# console.log "updated candidates"
						# console.log affected_cage.candidates[cand_group]

			when 2
				affected_col = new_sq.column_id

				for i in [0...@size]
					square = @display[i][affected_col]
					# console.log "     checking affected column"
					# console.log square
					for cage in @cages
						if cage.id is square.cage_id
							affected_cage = cage
							for i in [0...affected_cage.location.length]
								if affected_cage.location[i] is square
									loc_index = i
					# console.log "affected_cage"
					# console.log affected_cage
					# console.log "loc_index"
					# console.log loc_index
					# rem_array = []
					# rem_val = []
					for cand_group, cand of affected_cage.candidates
						# console.log "cand before removal"
						# console.log cand
						rem_array = []
						for candidate in cand
							# console.log "candidate"
							# console.log candidate
							# console.log "candidate[loc_index]"
							# console.log candidate[loc_index]
							# console.log "new_sq.value"
							# console.log new_sq.value
							if candidate[loc_index] is new_sq.value
								# console.log "removing #{candidate} from cand"
								rem_array.push candidate
						# console.log "cand post removal"
						if rem_array.length isnt 0
							# console.log "rem_array has vals..."
							# console.log rem_array
							output = affected_cage.candidates[cand_group]
							for candidate in rem_array
								# console.log "candidate in new_cand"
								# console.log candidate
								output = @remove output, candidate
								# console.log "output"
								# console.log output
							affected_cage.candidates[cand_group] = output

						# console.log "updated candidates"
						# console.log affected_cage.candidates[cand_group]
	# update_affected_candidates_2: (row_id, value) ->
	# 	for square
		
	add_cage: (cage) ->
		@cages.push cage

	remove_cage: () ->

	add_solution: (solution) ->
		@solution = solution

	verify_correct: () ->
		# console.log @solution
		if @solution.length is []
			console.log "shouldn't be here..."
			for i in [0..@size]
				if @display[i].value?
					if @display[i].value isnt @solution[i]
						return false
				else
					return false
		else
			if @check_rows_are_valid( ) is false
				# console.log "rows invalid"
				return false
			if @check_cols_are_valid( ) is false
				# console.log "cols invalid"
				return false
			if @check_cages_are_valid( ) is false
				# console.log "cages invalid"
				return false
			return true

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
		# for square in @display
		# 	if square.id is square_id
		# 		return square
	
	# These two functions allow the js sort method to sort numerically
	# as opposed to lexicographically.
	# ie, [9, 10, 54, 300] instead of [10, 300, 54, 9]
	descending: (a,b) ->
		return b-a

	ascending: (a,b) ->
		return a-b

	remove: (arr, val) ->
		x for x in arr when x!=val
	
	remove_array: (arr, val) ->
		# console.log "    In remove_array method"
		output = []
		for current in arr
			# console.log "    current"
			# console.log current
			mismatch = false
			for i in [0...current.length]
				# console.log "current[i] = #{current[i]}, val[i] = #{val[i]}"
				if current[i] isnt val[i]
					mismatch = true
					break
			output.push current if mismatch is true
		# console.log "output"
		# console.log output
		return output

this.Grid = Grid