define (require, exports, module) ->

	Bo = require 'bo'

	paneIdCounter = 0

	makePane: (id) ->
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

		hide: =>
			@element.classList.remove 'active'

		show: =>
			@element.classList.add 'active'

		toggle: =>
			@element.classList.toggle 'active'