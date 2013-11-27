# Bo.Pane

UI panes (one pane = one "screen")

	class Pane

		id: null
		element: null

## Pane.options

everything is optional, otherwise uses sensible defaults

		constructor: (@options) ->

			++@factory.counter

			element = @options.element
			html = @options.html
			idAttr = if element then element.getAttribute @options.paneAttribute else undefined

			@id = @options.id or idAttr or do @factory.id
			@element = element or do @factory.create
			@index = @options.index or @factory.counter

			# set ID
			@element.setAttribute @options.paneAttribute, @id

			# set HTML?
			if html
				@element.innerHTML = html

		factory:

			counter: 0

			create: ->

				element = document.createElement 'div'
				element.setAttribute 'data-bo-pane', do @id
				document.body.appendChild element
				element

			id: ->

				"pane-#{@counter}"

		clearAnimation: =>

			@element.classList.remove 'animate'

		animate: (instant) ->

			if not instant
				@element.classList.add 'animate'
				setTimeout @clearAnimation, @options.animationDuration

		left: _.fluent (instant) ->

			@animate instant
			@element.classList.remove 'right'
			@element.classList.add 'left'

		right: _.fluent (instant) ->

			@animate instant
			@element.classList.remove 'left'
			@element.classList.add 'right'

		show: _.fluent (instant) ->

			@animate instant
			@element.classList.remove 'left'
			@element.classList.remove 'right'
