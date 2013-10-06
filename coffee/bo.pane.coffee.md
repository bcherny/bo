# Bo.Pane

UI panes (one pane = one "screen")

	define (require, exports, module) ->

		Bo = require 'bo'
		_ = require 'util'

		paneIdCounter = 0

		makePane = (id) ->
			element = document.createElement 'div'
			element.setAttribute 'data-bo-pane', id
			document.body.appendChild element
			element

		makeId = (counter) ->
			'pane' + counter

		class Bo.Pane

			id: null
			element: null

## Pane.options

everything is optional, otherwise uses sensible defaults

			constructor: (@options) ->

				++paneIdCounter

				element = @options.element
				html = @options.html
				idAttr = if element then element.getAttribute 'data-bo-pane' else undefined
				@id = @options.id or idAttr or makeId paneIdCounter
				@element = element or makePane @id
				@index = @options.index or paneIdCounter

				# set ID
				@element.setAttribute 'data-bo-pane', @id

				# set HTML?
				if html
					@element.innerHTML = html

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
