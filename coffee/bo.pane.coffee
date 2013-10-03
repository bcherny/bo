define (require, exports, module) ->

	Bo = require 'bo'

	paneIdCounter = 0

	makePane = (id) ->
		element = document.createElement 'div'
		element.setAttribute 'data-bo-pane', id
		document.body.appendChild element
		element

	makeId = ->
		'pane' + (++paneIdCounter)

	class Bo.Pane

		id: null
		element: null

		constructor: (@options) ->

			element = @options.element
			html = @options.html
			idAttr = if element then element.getAttribute 'data-bo-pane' else undefined
			@id = @options.id or idAttr or makeId()
			@element = element or makePane @id

			# set ID
			@element.setAttribute 'data-bo-pane', @id

			# set HTML?
			if html
				@element.innerHTML = html

		clearAnimation: =>

			console.log 'clear', @element

			@element.classList.remove 'animate'

		left: ->

			console.log 'left', @element

			@element.classList.add 'animate'
			@element.classList.remove 'right'
			@element.classList.add 'left'

			setTimeout @clearAnimation, @options.animationDuration

		right: ->

			console.log 'right', @element, @options.animationDuration

			@element.classList.add 'animate'
			@element.classList.remove 'left'
			@element.classList.add 'right'

			setTimeout @clearAnimation, @options.animationDuration

		show: ->

			console.log 'show', @element

			@element.classList.add 'animate'
			@element.classList.remove 'left'
			@element.classList.remove 'right'

			setTimeout @clearAnimation, @options.animationDuration
