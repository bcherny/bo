define (require, exports, module) ->

	Pane = require 'bo.pane'

	class Bo

		options:

			paneAttribute: 'data-bo-pane'
			paneTriggerAttribute: 'data-bo-trigger-pane'

		panes: {}
		state: {}

		constructor: ->

			# load panes from DOM
			panes = document.querySelectorAll '[' + @options.paneAttribute + ']'

			# init panes
			for element in panes
				@registerPane element

			# show first pane
			@showFirst()

			# events
			document.addEventListener 'click', @click

		# {String|Number} key
		get: (key) ->

			@state[key]

		# {String|Number} key, {Mixed} value
		set: (key, value) ->

			@state[key] = value

		# {String|Number|DOMElement} element
		registerPane: (element) ->

			if typeof element is 'String' or typeof element is 'Number'

				pane = new Pane
					id: element
				@panes[element] = pane

			else

				pane = new Pane
					element: element
				@panes[pane.id] = pane

		hideAll: ->

			for id, pane of @panes
				pane.hide()

		showFirst: ->

			for id of @panes
				@show id
				break

		show: (id) ->

			# sanity check
			if not @panes[id]?
				console.error 'Bo.show called with unregistered pane "' + id + '". Be sure to register it first!'

			# hide panes
			@hideAll()

			# show this pane
			@panes[id].show()

			# register it
			@set 'active', id

		click: (event) =>

			id = event.target.getAttribute @options.paneTriggerAttribute

			if id

				event.preventDefault()

				@show id