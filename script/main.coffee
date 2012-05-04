class Main

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

	# Adapted from PPK's cookie methods
	window.setCookie = ( name, value, days ) ->
		if days
			date = new Date( )
			date.setTime date.getTime( ) + ( days * 24 * 60 * 60 * 1000 )
			expires = "; expires=#{date.toGMTString( )}"
		else
			expires = ""
		document.cookie = "#{name}=#{value}#{expires}; path=/"

	window.getCookie = ( name ) ->
		nameEQ = "#{name}="
		ca = document.cookie.split ';'
		for c in ca
			while ' ' is c.charAt 0
				c = c.substring 1, c.length
			if 0 is c.indexOf nameEQ
				return c.substring nameEQ.length, c.length
		null

	window.deleteCookie = ( name ) ->
		setCookie name, "", -1

	constructor: ->
		@edit_mode = true
		@welcome_dialog( )
		@build_DOM( )

		# $( 'input:[name="mode"]' ).click @switch_modes( )
		#n = 3
		#@main_grid = new Grid(n)

		test_case = 3
		
		switch (test_case)
			when 1
				# TEST CAGE 1 - EASY pg1
				# solution = 
				# 3 2 1
				# 2 1 3
				# 1 3 2
				n = 3
				@main_grid = new Grid(n)
				console.log @main_grid


				cage = new Cage([@main_grid.get_square("A1"), @main_grid.get_square("A2")])
				cage.update_target(5)
				cage.update_operation("+")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				#console.log(@main_grid.cages)

				cage = new Cage([@main_grid.get_square("B1"), @main_grid.get_square("B2")])
				cage.update_target(2)
				cage.update_operation("/")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)
				#console.log(@main_grid.cages)

				cage = new Cage([@main_grid.get_square("A3"), @main_grid.get_square("B3")])
				cage.update_target(2)
				cage.update_operation("-")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)
				#console.log(@main_grid.cages)

				cage = new Cage([@main_grid.get_square("C1")])
				cage.update_target(1)
				cage.update_operation("+")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)
				#console.log(@main_grid.cages)

				cage = new Cage([@main_grid.get_square("C2"), @main_grid.get_square("C3")])
				cage.update_target(6)
				cage.update_operation("*")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				# console.log "A1 cage_id = #{@main_grid.display[0][0].cage_id}"

				$('body').append( '''
				<table border="1">
				<tr>
					<td id="A1"> </td>
					<td id="A2"> </td>
					<td id="A3"> </td>
				</tr>
				<tr>
					<td id="B1"> </td>
					<td id="B2"> </td>
					<td id="B3"> </td>
				</tr>
				<tr>
					<td id="C1"> </td>
					<td id="C2"> </td>
					<td id="C3"> </td>
				</tr>
				</table>
				''')

				# console.log("grid - cages")
				# console.log(@main_grid.cages)

			when 2

				n = 4
				@main_grid = new Grid(n)

				cage = new Cage([@main_grid.get_square("A1")])
				cage.update_target(4)
				cage.update_operation("+")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("A2"), @main_grid.get_square("B2"), @main_grid.get_square("B3")])
				cage.update_target(12)
				cage.update_operation("*")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("A3"), @main_grid.get_square("A4")])
				cage.update_target(2)
				cage.update_operation("-")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("B1"), @main_grid.get_square("C1")])
				cage.update_target(2)
				cage.update_operation("/")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("B4"), @main_grid.get_square("C4")])
				cage.update_target(3)
				cage.update_operation("-")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("C2"), @main_grid.get_square("C3"), @main_grid.get_square("D3")])
				cage.update_target(11)
				cage.update_operation("+")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("D1"), @main_grid.get_square("D2")])
				cage.update_target(4)
				cage.update_operation("+")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("D4")])
				cage.update_target(2)
				cage.update_operation("+")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				$('body').append( '''
				<table border="1">
				<tr>
					<td id="A1"> </td>
					<td id="A2"> </td>
					<td id="A3"> </td>
					<td id="A4"> </td>
				</tr>
				<tr>
					<td id="B1"> </td>
					<td id="B2"> </td>
					<td id="B3"> </td>
					<td id="B4"> </td>
				</tr>
				<tr>
					<td id="C1"> </td>
					<td id="C2"> </td>
					<td id="C3"> </td>
					<td id="C4"> </td>
				</tr>
				<tr>
					<td id="D1"> </td>
					<td id="D2"> </td>
					<td id="D3"> </td>
					<td id="D4"> </td>
				</tr>
				</table>
				''')
		
			when 3

				# TEST CAGE 3 - DIFFICULT pg42
				# 2 1 4 5 3
				# 1 5 3 4 2
				# 3 2 5 1 4
				# 4 3 1 2 5
				# 5 4 2 3 1
				n = 5
				@main_grid = new Grid(n)

				cage = new Cage([@main_grid.get_square("A1"), @main_grid.get_square("A2"), @main_grid.get_square("B1"), @main_grid.get_square("C1"), @main_grid.get_square("C2")])
				cage.update_target(12)
				cage.update_operation("*")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("A3"), @main_grid.get_square("A4"), @main_grid.get_square("B2"), @main_grid.get_square("B3"), @main_grid.get_square("B4")])
				cage.update_target(21)
				cage.update_operation("+")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("A5"), @main_grid.get_square("B5"), @main_grid.get_square("C5")])
				cage.update_target(24)
				cage.update_operation("*")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("C3"), @main_grid.get_square("C4")])
				cage.update_target(4)
				cage.update_operation("-")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("D1"), @main_grid.get_square("D2"), @main_grid.get_square("E1"), @main_grid.get_square("E2")])
				cage.update_target(16)
				cage.update_operation("+")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("D3"), @main_grid.get_square("E3"), @main_grid.get_square("E4"), @main_grid.get_square("E5")])
				cage.update_target(6)
				cage.update_operation("*")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("D4"), @main_grid.get_square("D5")])
				cage.update_target(3)
				cage.update_operation("-")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				console.log("grid - cages")
				console.log(@main_grid.cages)
				
				$('body').append( '''
				<table border="1">
				<tr>
					<td id="A1"> </td>
					<td id="A2"> </td>
					<td id="A3"> </td>
					<td id="A4"> </td>
					<td id="A5"> </td>
				</tr>
				<tr>
					<td id="B1"> </td>
					<td id="B2"> </td>
					<td id="B3"> </td>
					<td id="B4"> </td>
					<td id="B5"> </td>
				</tr>
				<tr>
					<td id="C1"> </td>
					<td id="C2"> </td>
					<td id="C3"> </td>
					<td id="C4"> </td>
					<td id="C5"> </td>
				</tr>
				<tr>
					<td id="D1"> </td>
					<td id="D2"> </td>
					<td id="D3"> </td>
					<td id="D4"> </td>
					<td id="D5"> </td>
				</tr>
				<tr>
					<td id="E1"> </td>
					<td id="E2"> </td>
					<td id="E3"> </td>
					<td id="E4"> </td>
					<td id="E5"> </td>
				</tr>
				</table>
				''')
			
			when 4

				# TEST CAGE 4 - V. DIFFICULT pg 89
				# 5 2 3 1 6 4
				# 3 6 1 5 4 2
				# 4 1 2 6 5 3
				# 1 4 5 3 2 6
				# 2 5 6 4 3 1
				# 6 3 4 2 1 3

				n = 6
				@main_grid = new Grid(n)
				
				cage = new Cage([@main_grid.get_square("A1"), @main_grid.get_square("A2"), @main_grid.get_square("A3"), @main_grid.get_square("B1")])
				cage.update_target(90)
				cage.update_operation("*")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("A4"), @main_grid.get_square("A5"), @main_grid.get_square("A6"), @main_grid.get_square("B6")])
				cage.update_target( 13 )
				cage.update_operation("+")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("B2"), @main_grid.get_square("C1"), @main_grid.get_square("C2")])
				cage.update_target(11 )
				cage.update_operation("+")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("B3"), @main_grid.get_square("B4")])
				cage.update_target( 4 )
				cage.update_operation("-")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("B5"), @main_grid.get_square("C5"), @main_grid.get_square("C6")])
				cage.update_target( 60 )
				cage.update_operation("*")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("C3"), @main_grid.get_square("C4"), @main_grid.get_square("D4"), @main_grid.get_square("D5")])
				cage.update_target( 180 )
				cage.update_operation("*")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("D1"), @main_grid.get_square("E1")])
				cage.update_target( 2 )
				cage.update_operation("/")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("D2"), @main_grid.get_square("E2")])
				cage.update_target( 1 )
				cage.update_operation("-")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("D5"), @main_grid.get_square("E5")])
				cage.update_target(6 )
				cage.update_operation("*")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("D6"), @main_grid.get_square("E6")])
				cage.update_target( 5 )
				cage.update_operation("-")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("E3"), @main_grid.get_square("F1"), @main_grid.get_square("F2"), @main_grid.get_square("F3")])
				cage.update_target(432 )
				cage.update_operation("*")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)

				cage = new Cage([@main_grid.get_square("E4"), @main_grid.get_square("F4"), @main_grid.get_square("F5"), @main_grid.get_square("F6")])
				cage.update_target(12 )
				cage.update_operation("+")
				cage.update_square_cage_ids()
				@main_grid.add_cage(cage)
			




		for cage in @main_grid.cages
			cage.find_all_candidates(@main_grid.size)

		console.log @main_grid.cages

		console.log @main_grid
		
		# Timing function - start
		start = new Date().getTime()

		solver = new Solver(@main_grid)


		# console.log "Grid before removal"
		# console.log @main_grid
		# affected_sq = @main_grid.display[1][0]
		# affected_sq.set_value 3
		# console.log "affected_sq"
		# console.log affected_sq
		# @main_grid.update_affected_candidates 0, affected_sq, affected_sq.value
		# console.log "Grid after removal"
		# console.log @main_grid

		current_grid = @main_grid
		console.log current_grid
		_return = solver.solve(current_grid, 0)
		
		switch _return.status
			when "valid"
				console.log "WOO! Solution! :D"
				current_grid = _return.valid_grid
				break
			when "invalid"
				console.log "Boo! No solution :("
				break
			# when "update"
			# 	current_grid = _return.grid
			# 	_return = solver.solve(current_grid)
			when "debug"
				console.log "Debugging..."
				current_grid = _return.grid
				break
		end = new Date().getTime()
		time = end - start
		$('body').append(time)
		# current_grid = @main_grid
		# for i in [0..10]
		# 	console.log "iteration #{i}"
		# 	_return = solver.solve(current_grid)
		# 	console.log "_return = "
		# 	console.log _return
		# 	if _return.updated_grid?
		# 		current_grid = _return.updated_grid
		# 		depth = _return.depth
		# 	if _return.status is "valid"
		# 		console.log "WOO! Solution! :D"
		# 		current_grid = _return.valid_grid
		# 		break
		# 	if _return.status is "invalid"
		# 		console.log "Boo! No solution :'("
		# 		break

		$('#A1').append("#{current_grid.display[0][0].value}")
		$('#A2').append("#{current_grid.display[0][1].value}")
		$('#A3').append("#{current_grid.display[0][2].value}")
		if n > 3
			$('#A4').append("#{current_grid.display[0][3].value}")
			if n > 4
				$('#A5').append("#{current_grid.display[0][4].value}")
				if n > 5
					$('#A6').append("#{current_grid.display[0][5].value}")

		$('#B1').append("#{current_grid.display[1][0].value}")
		$('#B2').append("#{current_grid.display[1][1].value}")
		$('#B3').append("#{current_grid.display[1][2].value}")
		if n > 3
			$('#B4').append("#{current_grid.display[1][3].value}")
			if n > 4
				$('#B5').append("#{current_grid.display[1][4].value}")
				if n > 5
					$('#B6').append("#{current_grid.display[1][5].value}")

		$('#C1').append("#{current_grid.display[2][0].value}")
		$('#C2').append("#{current_grid.display[2][1].value}")
		$('#C3').append("#{current_grid.display[2][2].value}")
		if n > 3
			$('#C4').append("#{current_grid.display[2][3].value}")
			if n > 4
				$('#C5').append("#{current_grid.display[2][4].value}")
				if n > 5
					$('#C6').append("#{current_grid.display[2][5].value}")

		if n > 3
			$('#D1').append("#{current_grid.display[3][0].value}")
			$('#D2').append("#{current_grid.display[3][1].value}")
			$('#D3').append("#{current_grid.display[3][2].value}")
			$('#D4').append("#{current_grid.display[3][3].value}")
			if n > 4
				$('#D5').append("#{current_grid.display[3][4].value}")
				if n > 6
					$('#D6').append("#{current_grid.display[3][5].value}")
			if n > 4
				$('#E1').append("#{current_grid.display[4][0].value}")
				$('#E2').append("#{current_grid.display[4][1].value}")
				$('#E3').append("#{current_grid.display[4][2].value}")
				$('#E4').append("#{current_grid.display[4][3].value}")
				$('#E5').append("#{current_grid.display[4][4].value}")
				if n > 5
					$('#E6').append("#{current_grid.display[4][5].value}")

		if n > 5
			$('#F1').append("#{current_grid.display[5][0].value}")
			$('#F2').append("#{current_grid.display[5][1].value}")
			$('#F3').append("#{current_grid.display[5][2].value}")
			$('#F4').append("#{current_grid.display[5][3].value}")
			$('#F5').append("#{current_grid.display[5][4].value}")
			$('#F6').append("#{current_grid.display[5][4].value}")

		# console.log solver.get_potentials(@main_grid)

		# console.log solver.get_potentials(@main_grid)

		# solver.solve while solver.solve isnt "update"
		# solver_return = solver.solve( @main_grid )
		# console.log solver_return
		# solver_return = while solver.solve is "update"

		
		# switch solver_return
		# 	when "invalid"
		# 		console.log "Sorry, no solution available."
		# 	when "valid"
		# 		console.log "A solution has been found"
		# 	when

		console.log @main_grid.cages

		###temp = ["B1","B2"]
		@main_grid.add_cage(temp)
		temp = ["A3", "B3"]
		@main_grid.add_cage(temp)
		temp = ["C1"]
		@main_grid.add_cage(temp)
		temp = ["C2","C3"]
		@main_grid.add_cage(temp)
		console.log(@main_grid.cages)
		###

	build_DOM: ->
			$('body').append('''
			<form method="post" action="">
				<input name="radio1" type="radio" checked="checked" value="edit">Edit Mode</input>
				<input name="radio1" type="radio" value="solve">Solve Mode</input>
			</form>
			<div id="edit_mode"> This is edit_mode </div>
			<div id="solve_mode"> This is solve_mode </div>
			''')

			$('#solve_mode').css
				opacity:0
				display:"none"	

			`$(function(){
				$('input:[name="radio1"]').lightSwitch({
					switchImg:'img/switch-1.png',
					animSpeed:250
				});
			});`

	# switch_modes: ->

	# $(function(){
	# 	$('input:[name="radio1"]').lightSwitch({
	# 		switchImg:'img/switch-1.png',
	# 		animSpeed:250
	# 	});
	# });
			# });`

	welcome_dialog: ->
		if "false" isnt getCookie "welcome"
			@modal = new Modal
				title: "Welcome to Solvr!"
				intro: """
					<p>
						Welcome screen text. Lorem ipsum. Lorem ipsum. Lorem ipsum. Lorem ipsum.
						Lorem ipsum. Lorem ipsum. Lorem ipsum. Lorem ipsum. Lorem ipsum.
						Lorem ipsum. Lorem ipsum. Lorem ipsum. Lorem ipsum. Lorem ipsum.
						Insert an img below
					</p>
					<img src="img/welcome1.png" alt="Toolbar Diagram" />
					<p>
						Some extra explanation text. Yeah, boi! Maybe take user input...
					</p>
					"""
				okay: "Don't show this again!"
				cancel: "Okay, thanks!"
				callback: ( r ) ->
					setCookie "welcome", "false"
			@modal.show( )

this.Main = Main