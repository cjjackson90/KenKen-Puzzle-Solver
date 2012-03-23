class Main

	# Executes on document.ready event
	$ ->
		# Stop IE text selection
		$( 'body' ).onselectstart = -> false

		# Instantiates the main class and starts the program
		window.APP = new Main

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
		n = 5
		@main_grid = new Grid(n)

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