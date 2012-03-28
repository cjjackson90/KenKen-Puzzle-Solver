class Solver
	
	current_puzzle: null
	solution_order: []
	
	constructor: () ->
		
	solve: (grid) ->
		if grid.verify_correct( ) is true
			return valid
		
		if cages_have_candidates( ) is false
			return invalid

		# TODO: Implement strategies.

		if backtrack(grid) is invalid
			return invalid
		else
			return update

	backtrack: (grid) ->
		profitable_cage # Chose some method of selecting a profitable cage for backtracking. Store id.
		potentials = []

		###for candidate in profitable_cage
			temp = grid
			temp.
			potentials.push
		###

	append_solution_order: (fresh_vals) ->

	update_puzzle_info: () ->
		

this.Solver = Solver