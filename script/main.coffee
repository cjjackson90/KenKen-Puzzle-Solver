class Main

	# ### BEGIN: Helper methods and bootstrapping.
	
	# Executes on document.ready event
	$ ->
		# Stop IE text selection
		$( 'body' ).onselectstart = -> false

		# Instantiates the main class and starts the program
		window.APP = new Main

	# ### window.uniqueId( )
	# Generates a Unique ID. Taken from [here]
	# (http://coffeescriptcookbook.com/chapters/strings/generating-a-unique-id)
	# #### Parameters
	# * `length` - Length of generated id string
	window.uniqueId = ( length = 3 ) ->
		id = ""
		id += Math.random( ).toString( 36 ).substr( 2 ) while id.length < length
		id.substr 0, length

	# ### window.setCookie( name, value, days )
	# Adapted from PPK's cookie methods. Allows cookies to be set
	# if needed.
	# ### Parameters
	# * `name' - name of the cookie
	# * `value' - data stored in the cookie
	# * `date' - expiry date for the cookie
	window.setCookie = ( name, value, days ) ->
		if days
			date = new Date( )
			date.setTime date.getTime( ) + ( days * 24 * 60 * 60 * 1000 )
			expires = "; expires=#{date.toGMTString( )}"
		else
			expires = ""
		document.cookie = "#{name}=#{value}#{expires}; path=/"

	# ### window.getCookie( name )
	# Checks cookies for cookie titled name. Returns the cookie if found
	# and null otherwise.
	# ### Parameters
	# * `name' - the cookie we wish to return.
	window.getCookie = ( name ) ->
		nameEQ = "#{name}="
		ca = document.cookie.split ';'
		for c in ca
			while ' ' is c.charAt 0
				c = c.substring 1, c.length
			if 0 is c.indexOf nameEQ
				return c.substring nameEQ.length, c.length
		null

	# ### window.deleteCookie( name )
	# Finds and deletes the cookie `name'.
	# ### Parameters
	# * `name' - cookie to be deleted
	window.deleteCookie = ( name ) ->
		setCookie name, "", -1

	# ### END: Helper methods and bootstrapping



	# boolean for if the add cage dialog box is open.
	add_cage_dialog_open = false

	# index for where in the `stepping through' process
	# the user currently is.
	position_in_display = 0
	
	# ### main.constructor( )
	# Builds the site DOM, initialises a default empty grid and assigns
	# event triggers to buttons.
	constructor: ->
		@build_DOM( )

		# Initialises main grid to a default of 5x5
		@main_grid = new Grid( 5 )

		# Event - grid size on UI changed.
		$('#grid_size').change ( e ) => @update_grid_size( $('#grid_size').val() )
		
		# Event - user clicks `add cage' button
		$('#add_cage').click ( e ) => @add_cage_click( )

		# Event - user changes to solve mode from edit mode.
		$('#solve_mode_button').click ( e ) => @solve_mode_button_click( )

		# Event - user changes to edit mode from solve mode.
		$('#edit_mode_button').click ( e ) => @edit_mode_button_click( )

		# Event - user presses reset button in solve mode.
		$('#solve_reset').click ( e ) => @solve_reset( )

		# Event - user presses solution button in solve mode.
		$('#solve_solution').click ( e ) => @solve_solution_button_click( )

		# Event - user presses step button to show next stage of solution.
		$('#solve_step').click ( e ) => @solve_next_step( )

	# ### main.build_DOM
	# Builds basic DOM for website.
	build_DOM: ->
		$('body').append('''
		<div id="main">
			<div id="modes">
				<div id="edit_mode">
					<div id="edit_top_bar" class="top_bar"></div>
					<div id="edit_side_bar" class="side_bar" float="left">
						<img src="img/grid_size.png">
						<input id="grid_size" type="text" size="1"></input>
						<p>
						<p>
						<div id="add_cage">
							<div float="left"><img src="img/add_cage2.png"></div>
						</div>
					</div>
				</div>
				
				<div id="solve_mode">
					<div id="solve_top_bar" class="top_bar"></div>
					<div id="solve_side_bar" class="side_bar" float="left">
						<div id="solve_reset">
							<img src="img/reset.png">
						</div>
						<div id="solve_step">
							<img src="img/next_step.png">
						</div>
						<div id="solve_solution">
							<img src="img/solution.png">
						</div>
					</div>
				</div>

				<ul>
					<li><a id="edit_mode_button" href="#edit_mode">Edit Mode</a></li>
					<li><a id="solve_mode_button" href="#solve_mode">Solve Mode</a></li>
				</ul>
			</div>
		</div>
		''')

		# Create tabs for the two different modes.
		$('#modes').tabs( )

		# Change classes of tab elements to do css for bottom-positioned tabs.
		$( ".tabs-bottom .ui-tabs-nav, .tabs-bottom .ui-tabs-nav > * ")
			.removeClass( "ui-corner-all ui-corner-top" )
			.addClass( "ui-corner-bottom" )

	# ### main.update_grid_size( grid_size )
	# Changes the grid size to input value. If this is
	# invalid an alert is shown. Otherwise, remove current
	# grid and recreate with new valid size.
	# ### Parameters
	# * `grid_size' - new grid size
	update_grid_size: (grid_size) ->
		console.log grid_size
		if (grid_size > 9 or grid_size < 1)
			alert("Sorry, grid sizes must a value 1-9.")
			$('#grid_size').val(@main_grid.size)
		else
			$('#grid_lines').remove()
			$('#edit_grid_wrapper > *').remove()
			@main_grid = new Grid( grid_size )

	# ### main.add_cage_click( )
	# Called when `add cage' button is clicked.
	# If add cage dialog is open close and exit. Otherwise,
	# open cage dialog. If user then clicks `add' a cage object
	# is created using the selected squares and target/operation
	# values.
	add_cage_click: ->
		# $('#add_cage').css("visibility", "hidden")
		if (@add_cage_dialog_open)
			$('#add_cage_dialog').remove()
			$('.ui-selected').removeClass('ui-selected')
			$('#edit_grid_wrapper').selectable("destroy")
			$('#add_cage').css("visibility", "visible")
			@add_cage_dialog_open = false
			return

		@add_cage_dialog_open = true
		$('#edit_grid_wrapper').selectable()
		$('#edit_side_bar').append('''
		<div id="add_cage_dialog" class="instructions">
			Ctrl+Click squares to add to cage.
			<p>
			Target: <input id="target_val" type="text" size="5"></input>
			<p>
			Operation: <select id="op_val">
				<option value="+">+</option>
				<option value="-">-</option>
				<option value="*">*</option>
				<option value="/">/</option>
			</select>
			<p>
			<div position="absolute">
				<div id="add_cage_ok">Add</div>
				<p>
				<div id="add_cage_cancel">Cancel</div>
			<div>
		</div>
		''')



		$('#add_cage_ok').click ( e ) =>
			target = $('#target_val').val()
			selected_squares = $('.ui-selected').get()
			selected_ids = []
			squares = []
			for sq in selected_squares
				selected_ids.push $(sq).attr('id')
				squares.push @main_grid.get_square( $(sq).attr('id') )

			cage = new Cage(squares)
			cage.update_target( parseInt(target) )
			cage.update_operation( $('#op_val').val() )
			cage.update_square_cage_ids( )
			cage.location[0].set_target_op( cage.target, cage.operation )
			@main_grid.add_cage( cage )
			
			first_sq = true
			for val in cage.location
				val_letter = val.row_id
				val_num = val.column_id+1

				if first_sq
					$('#'+val.id+' > div').append( val.target_op )
					first_sq = false

				to_check = []
				to_check.push String.fromCharCode(val_letter+64)+val_num
				to_check.push String.fromCharCode(val_letter+66)+val_num
				to_check.push String.fromCharCode(val_letter+65)+(val_num+1)
				to_check.push String.fromCharCode(val_letter+65)+(val_num-1)

				$('#'+val.id).css(
						"border": "8px solid #7FD13B"
					)

				for i in [0...4]
					if ( to_check[i] in selected_ids )
						switch i
							when 0
								$('#'+val.id).css(
									"border-top": "1px solid #D6ECFF"
								)
							when 1
								$('#'+val.id).css(
									"border-bottom": "1px solid #D6ECFF"
								)
							when 2
								$('#'+val.id).css(
									"border-right": "1px solid #D6ECFF"
								)
							when 3
								$('#'+val.id).css(
									"border-left": "1px solid #D6ECFF"
								)

			$('.ui-selected').removeClass("ui-selected")
			$('#add_cage').css("visibility", "visible")

		$('#add_cage_cancel').click ( e ) =>
			$('#add_cage_dialog').remove()
			$('.ui-selected').removeClass('ui-selected')
			$('#edit_grid_wrapper').selectable("destroy")
			$('#add_cage').css("visibility", "visible")

	# ### grid.solve_mode_button_click( )
	# Called when user changes to solve mode.
	# Copies grid from edit mode and calls solve algorithm. Logs
	# time taken to solve in the console.
	solve_mode_button_click: ->

		$('#solve_mode').append('''
		<div id="solve_grid_wrapper">
		</div>
		''')
		$('#edit_grid_wrapper').children().clone().appendTo( '#solve_grid_wrapper' )

		for cage in @main_grid.cages
			cage.find_all_candidates(parseInt(@main_grid.size))

		# Timing function - start
		start = new Date().getTime()
		solver = new Solver(@main_grid)

		current_grid = @main_grid
		_return = solver.solve(current_grid, 0)
		
		switch _return.status
			when "valid"
				console.log "WOO! Solution! :D"
				current_grid = _return.valid_grid
				break
			when "invalid"
				if (_return.reason?)
					console.log "Solvr timed out!"
				console.log "Boo! No solution :("
				break
			when "debug"
				console.log "Debugging..."
				current_grid = _return.grid
				break
		end = new Date().getTime()
		time = end - start
		console.log time

		@main_grid = current_grid
		@main_grid.add_solution( @main_grid.display )
		@main_grid.add_solution_order( solver.solution_order )

	# ### main.edit_mode_button_click( )
	# Called when user clicks to enter edit mode.
	# Removes the solve grid info, as though it were never called.
	edit_mode_button_click: ->
		$('#solve_grid_wrapper').remove()

	# ### main.solve_solution_button_click( )
	# Called when user clicks the `solve' button in solve mode.
	# Takes the grid's solution and populates the squares with
	# these values.  
	solve_solution_button_click: ->
		for sq in @main_grid.solution
			id = sq.id
			$('#solve_grid_wrapper > #'+id).append(sq.value)

	# ### main.solve_reset( )
	# Resets the `position in display' value, allowing the user to
	# step through the solution from the start, and resets the solve
	# grid (visual) to that of edit mode.
	solve_reset: ->
		position_in_display = 0
		$('#solve_grid_wrapper').empty()
		$('#edit_grid_wrapper').children().clone().appendTo('#solve_grid_wrapper')

	# ### main.solve_next_step( )
	# Uses the `position in display' index to step through the solution
	# and populate the correct squares in the grid.
	solve_next_step: ->
		for sq in @main_grid.solution_order[position_in_display]
			$('#solve_grid_wrapper > #'+sq.id).append(sq.value)
		position_in_display++

this.Main = Main