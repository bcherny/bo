define (require, exports, module) ->

	Model = require 'bo.model'
	Pane = require 'bo.pane'
	_ = require 'bo.util'

	class Bo

		options:

			animationDuration: 200
			paneAttribute: 'data-bo-pane'
			paneTriggerAttribute: 'data-bo-trigger-pane'

		events:

			'click': 'click'

		panes: {}
		state: new Model

		constructor: ->

			# load panes from DOM
			panes = document.querySelectorAll '[' + @options.paneAttribute + ']'

			# init panes
			_.each panes, @registerPane

			# hide all panes
			@hideAll()

			# show first pane
			@show _.one @panes

			# events
			_.each @events, @attachEvent

		attachEvent: (fn, type) =>

			document.addEventListener type, @[fn]

		# {String|Number|DOMElement} element
		registerPane: (element) =>

			if typeof element is 'String' or typeof element is 'Number'
				opts =
					id: element

			else
				opts =
					element: element

			opts = _.extend opts, @options
			pane = new Pane opts
			@panes[pane.id] = pane

		hideAll: ->

			_.each @panes, (n, pane) ->
				pane.right true

		show: (id) ->

			# hide active pane
			newPane = @panes[id]
			oldPane = @state.get 'active'

			if oldPane

				# slide left
				if newPane.index > oldPane.index
					
					oldPane.left()
					newPane.right(true).show()

				# slide right
				else

					oldPane.right()
					newPane.left(true).show()

			# first call, just show this pane
			else
				newPane.show true

			# register it
			@state.set 'active', newPane

		click: (event) =>

			id = event.target.getAttribute @options.paneTriggerAttribute

			if id

				event.preventDefault()

				@show id