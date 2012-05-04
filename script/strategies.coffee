class Strategies

	constructor: () ->

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
			# for candidate in cage.candidates

		# vals_added = false
		# for cage in grid.cages
		# 	console.log "current_cage"
		# 	console.log cage
		# 	for cand_group, cand of cage.candidates
		# 		console.log "cand_group.length = #{cand_group.length}"
		# 		console.log "cand.length = #{cand.length}"
		# 		if cand.length is 1
		# 			valid = false
		# 			console.log cage.location
		# 			for sq in cage.location
		# 				if sq.value is null
		# 					valid = true
		# 					break
		# 			if valid
		# 				console.log "value is null; valid sq"
		# 				cage.add_candidate_to_grid( cand )
		# 				vals_added = true
		# 		# for i in [0...candidates[0].length]
		# 			# set_value( candidates[0][i] )
		# return vals_added
		return false

	common_numbers: (grid) ->
		# console.log "********** NEW CALL TO COMMON_NUMBERS!"
		# console.log grid
		for cage in grid.cages
			# console.log cage
			# console.log "new cage"
			# if cage.candid
			# console.log cage.candidates[0]
			# console.log cage.candidates.length
			# if cage.candidates.length 
			if cage.candidates.length is 0
				continue
			if cage.candidates[0].length > grid.size # or cage.candidates.length is 0
				continue
				# return_obj = 
				# 	status: false

			same_row = true
			same_col = true
			row_id = cage.location[0].row_id
			col_id = cage.location[0].column_id
			# console.log "row_id = #{row_id}, col_id = #{col_id}"

			for sq in cage.location
				if sq.row_id isnt row_id
					same_row = false
				if sq.col_id isnt col_id
					same_col = false

				if same_row is false and same_col is false
					return_obj =
						status:false

			if same_row
				console.log cage.candidates
				potentials = cage.candidates[0]
				console.log "potentials"
				console.log potentials

				temp = []
				for val in potentials
					console.log "val = #{val}"
					console.log "value of grid.rows[#{row_id}][#{val-1}] = #{grid.rows[row_id][val-1]}"
					if grid.rows[row_id][val-1] is null
						temp.push @remove( potentials, val )

				console.log temp
				for val in temp
					console.log "removing #{val} from #{potentials}"
					foo = @remove( potentials, val[0] )
					potentials = foo
					console.log potentials

				if potentials.length is 0
					continue

				for candidate in cage.candidates[1...cage.candidates.length]
					for val in potentials
						if (included = val in candidate) is false
							potentials = @remove( potentials, val )


				console.log "potentials reduced"
				console.log potentials

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
				console.log cage.candidates
				potentials = cage.candidates[0]
				console.log "potentials"
				console.log potentials

				temp = []
				for val in potentials
					console.log "val = #{val}"
					console.log "value of grid.columns[#{col_id}][#{val-1}] = #{grid.columns[col_id][val-1]}"
					if grid.columns[col_id][val-1] is null
						temp.push @remove( potentials, val )

				console.log temp
				for val in temp
					console.log "removing #{val} frp, #{potentials}"
					foo = @remove( potentials, val[0] )
					potentials = foo
					console.log potentials

				if potentials.length is 0
					continue

				for candidate in cage.candidates[1...cage.candidates.length]
					for val in potentials
						if (included = val in candidates) is false
							potentials = @remove( potentials, val )

				console.log "potentials reduced"
				console.log potentials

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