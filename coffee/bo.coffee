define (require, exports, module) ->

	Pane = require 'bo.pane'

	class Bo

		panes: {}

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

		hideAll: ->

			for id, pane of @panes
				pane.hide()

		showFirst: ->

			for id, pane of @panes
				pane.show()
				break

		show: (id) ->

			# hide panes
			@hideAll()

			# show this pane
			@panes[id].show()