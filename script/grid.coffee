class Grid
	
	size: null
	cages: []
	display: []
	solution: []
	rows: []
	columns: []


	constructor: (grid_size) ->
		size = grid_size
		for i in [0...size]
			rows[i] = []
			columns[i] = []
			for j in [1..size]
				rows[i][j] = j+1
				columns[j] = j+1
				display[i][j] = new Square(i,j)
	
	draw: () ->

	clear: () ->

	update_row: (row_id, col_id, val) ->

	update_column: (row_id, col_id, val) ->
		
	add_cage: () ->

	remove_cage: () ->

this.Grid = Grid