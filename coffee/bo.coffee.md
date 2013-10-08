# Bo main

Define Bo

	define 'bo', ->

		Model = require 'model'
		View = require 'view'
		Pane = require 'pane'
		_ = require 'util'

		class Bo extends View

## Options

			options:

				animationDuration: 200
				paneAttribute: 'data-bo-pane'
				paneTriggerAttribute: 'data-bo-trigger-pane'

## Events

			events:

				'touchstart click': 'click'

			panes: {}

			initialize: ->

load panes from DOM

				panes = document.querySelectorAll '[' + @options.paneAttribute + ']'

initialize panes

				_.each panes, @registerPane

hide all panes to start

				@hideAll()

then show first pane

				@show _.one @panes

## Bo.registerPane
`{String|Number|DOMElement} element`
Register panes from the DOM

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

			iterate: (fn) ->

				_.each @panes, fn

			hideAll: ->

				@iterate (pane) ->
					pane.right true

			restToLeft: (index) ->

				@iterate (pane) ->
					if pane.index < index
						pane.left true

			restToRight: (index) ->

				@iterate (pane) ->
					if pane.index > index
						pane.right true

			show: (id) ->

				# hide active pane
				newPane = @panes[id]
				oldPane = @get 'active'

				if not newPane
					throw new Error 'Pane with ID "' + id + '" does not exist in the DOM, or is not registered with Bo.'

				if oldPane

					index = newPane.index

					# slide left
					if index > oldPane.index
						
						oldPane.left()
						newPane.right(true).show()
						@restToLeft index # so we can skip panes when jumping

					# slide right
					else

						oldPane.right()
						newPane.left(true).show()
						@restToRight index # so we can skip panes when jumping

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