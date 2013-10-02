define (require, exports, module) ->

	Pane = require 'bo.pane'

	class Bo

		panes: {}
		state: {}

		constructor: ->

			# load panes from DOM
			panes = document.querySelectorAll '[data-bo-pane]'

			# init panes
			for element in panes
				pane = new Pane
					element: element
				@panes[pane.id] = pane

			# show first pane
			@showFirst()

		get: (key) ->

			@state[key]

		set: (key, value) ->

			@state[key] = value

		hideAll: ->

			for id, pane of @panes
				pane.hide()

		showFirst: ->

			for id of @panes
				@show id
				break

		show: (id) ->

			# hide panes
			@hideAll()

			# show this pane
			@panes[id].show()

			# register it
			@set 'active', id