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

		animate: ({ direction, instant } = { direction: 'left', instant: no }) ->

			oppositeDirections = ['center', 'left', 'right'].filter (_) -> _ isnt direction

			new Promise (resolve) =>

				@element.classList.remove 'hidden'

				_onEnd = =>
					@element.removeEventListener _onEnd
					do _onAfterEnd
					do resolve

				_onAfterEnd = =>
					@element.classList.remove "animate-#{ direction }"
					oppositeDirections.forEach (_) => @element.classList.remove _
					@element.classList.add direction
					@element.classList.add 'hidden'

				if instant
					do _onAfterEnd
					setTimeout(resolve, 0)
				else
					@element.classList.add "animate-#{ direction }"
					@element.addEventListener 'animationend', _onEnd, no

		left: ({ instant } = { instant: no }) ->

			@animate
				direction: 'left'
				instant: instant

		right: ({ instant } = { instant: no }) ->

			@animate
				direction: 'right'
				instant: instant

		show: ({ instant } = { instant: no }) ->

			@animate
					direction: 'center'
					instant: instant