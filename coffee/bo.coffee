require.config
	paths:
		izzy: '../node_modules/izzy/izzy'

define (require, exports, module) ->

	Model = require 'bo.model'
	View = require 'bo.view'
	Pane = require 'bo.pane'
	_ = require 'bo.util'

	class Bo extends View

		options:

			animationDuration: 200
			paneAttribute: 'data-bo-pane'
			paneTriggerAttribute: 'data-bo-trigger-pane'

		events:

			'touchstart click': 'click'

		panes: {}

		initialize: ->

			# load panes from DOM
			panes = document.querySelectorAll '[' + @options.paneAttribute + ']'

			# init panes
			_.each panes, @registerPane

			# hide all panes
			@hideAll()

			# show first pane
			@show _.one @panes

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

			_.each @panes, (pane) ->
				pane.right true

		show: (id) ->

			# hide active pane
			newPane = @panes[id]
			oldPane = @get 'active'

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
			@set 'active', newPane

		click: (event) =>

			id = event.target.getAttribute @options.paneTriggerAttribute

			if id

				event.preventDefault()

				@show id