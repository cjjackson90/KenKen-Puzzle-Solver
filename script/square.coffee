class Square
	
	# ID of the square - ie, A1, C3, etc.
	id: null

	# Stores the string combination of both the target and operator
	target_op: null

	# Value stores the value of this square as it would appear in the grid
	value: null

	# Stores the reference to the containing row. A = 0, B = 1, C = 2, etc.
	row_id: null

	# Stores the letter value of row_id.
	row_id_char: null

	# Stores the reference to the containing column.
	column_id: null

	# Stores the id of the cage this square belongs to
	cage_id: null

	# ### Square.constructor( row_id, column_id )
	# Takes the row/column references to build this square.
	# Finds the row_id_char and id from these values.
	# ### Parameters
	# * `row_id' - the numerical reference to the containing row
	# * `col_id' - the numerical reference to the containing column
	constructor: (@row_id, @column_id) ->
		@row_id_char = String.fromCharCode(row_id+65)
		@id = (@row_id_char) + (column_id+1) 
		#console.log(@id)
	
	# ### Square.set_cage_id( cage_id )
	# Updates the reference to the cage which contains this square.
	# ### Parameters
	# * `cage_id' - the new cage id.
	set_cage_id: (@cage_id) ->

	# ### Square.set_value( value )
	# Updates the value of the square.
	# ### Parameters
	# * `value' - the new value of the square.
	set_value: (@value) ->

	# ### Square.set_target_op( target_val, op )
	# Updates the target_op string by concatenating target_val and op.
	# ### Parameters
	# * `target_val' - the target of the parent cage.
	# * `op' - the operator of the parent cage.
	set_target_op: (target_val, op) ->
		@target_op = target_val + op

this.Square = Square