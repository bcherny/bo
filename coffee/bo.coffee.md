# Bo main

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

init model

			@model.set 'active', null

load panes from DOM

			panes = document.querySelectorAll '[' + @options.paneAttribute + ']'

initialize panes

			_.each panes, @registerPane

hide all panes to start

			@hideAll()

remove display:none

			@displayBlock()

then show first pane
			
			@show _.one @panes

## Bo.displayBlock
Overrides `display:none` CSS rule that hides panes initially

		displayBlock: ->

			@iterate (pane) ->
				pane.element.style.display = 'block'

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

## Bo.iterate
`{Function} fn`
Generic pane iterator that applies `fn` to every pane

		iterate: (fn) ->

			_.each @panes, fn

## Bo.hideAll
Hides all panes

		hideAll: ->

			@iterate (pane) ->
				pane.right true

## Bo.restToLeft
Lets us navigate >1 layer at a time

		restToLeft: (index) ->

			@iterate (pane) ->
				if pane.index < index
					pane.left true

## Bo.restToRight
Lets us navigate >1 layer at a time

		restToRight: (index) ->

			@iterate (pane) ->
				if pane.index > index
					pane.right true

## Bo.show
`{Number|String} id`
Slides in the pane with the given `id`

		show: (id) ->

			# hide active pane
			newPane = @panes[id]
			oldPane = @model.get 'active'

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
			@model.set 'active', newPane

## Bo.click
{Event} event
Click handler, activates a pane when its trigger is clicked

		click: (event) =>

			id = event.target.getAttribute @options.paneTriggerAttribute

			if id

				event.preventDefault()

				@show id