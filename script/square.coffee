class Square
	
	id: null
	target_op: null
	value: null
	row_id: null
	row_id_char: null
	column_id: null
	cage_id: null


	constructor: (row_id, column_id) ->
		@row_id = row_id
		@column_id = column_id
		@row_id_char = String.fromCharCode(row_id+65)
		@id = (@row_id_char) + (column_id+1) 
		#console.log(@id)
	
	set_cage_id: (cage_id) ->
		@cage_id = cage_id

	set_value: (new_val) ->
		@value = new_val

	set_target_op: (target_val, op) ->
		@target_op = target_val + op


this.Square = Square