class Strategies

	constructor: () ->

	one_candidate: (grid) ->
		vals_added = false
		vals = []
		for cage in grid.cages
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
			grid: grid
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
		return false

	certain_vals: (grid) ->
		return false

this.Strategies = Strategies