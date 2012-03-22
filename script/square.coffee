class Square
	
	id: null
	target_op: null
	value: null
	row_id: null
	column_id: null
	cage_id: null


	constructor: (row_id, column_id) ->
		@row_id = row_id
		@column_id = column_id
		@id = (String.fromCharCode(row_id+97)) + (column_id+1) 
	
	set_cage_id: (cage_id) ->

	set_value: (new_val) ->

	set_target_op: (target_val, op) ->

this.Square = Square