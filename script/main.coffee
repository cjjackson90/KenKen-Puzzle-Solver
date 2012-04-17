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
		@welcome_dialog( )
		#n = 3
		#@main_grid = new Grid(n)

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

		console.log "A1 cage_id = #{@main_grid.display[0][0].cage_id}"

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
		

		# TEST CAGE 2 - DIFFICULT pg42
		###
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
		###

		# TEST CAGE 3 - V. DIFFICULT pg 89
		###
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
		###

		for cage in @main_grid.cages
			cage.find_all_candidates(@main_grid.size)

		console.log @main_grid.cages

		console.log @main_grid
		
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
		for i in [0..10]
			console.log "iteration #{i}"
			_return = solver.solve(current_grid)
			console.log _return
			if _return.updated_grid?
				current_grid = _return.updated_grid
			if _return.status is "valid"
				console.log "WOO! Solution! :D"
				current_grid = _return.valid_grid
				break
			if _return.status is "invalid"
				console.log "Boo! No solution :'("
				break

		$('#A1').append("#{current_grid.display[0][0].value}")
		$('#A2').append("#{current_grid.display[0][1].value}")
		$('#A3').append("#{current_grid.display[0][2].value}")
		$('#B1').append("#{current_grid.display[1][0].value}")
		$('#B2').append("#{current_grid.display[1][1].value}")
		$('#B3').append("#{current_grid.display[1][2].value}")
		$('#C1').append("#{current_grid.display[2][0].value}")
		$('#C2').append("#{current_grid.display[2][1].value}")
		$('#C3').append("#{current_grid.display[2][2].value}")
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