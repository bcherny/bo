# Bo main

	class Bo extends View

## Options

		options:

			paneAttribute: 'bo-pane'
			paneTriggerAttribute: 'bo-trigger'
			change: ->

## Events

		events:

			'touchstart click': 'click'

		panes: {}

## Initialize

		initialize: (options) ->

set options
			
			_.extend @options, options

model events

			@model.on 'set:active', (key, pane) =>
				if pane
					@options.change.call @, pane

init model

			@model.set 'active', null

load panes from DOM

			panes = document.querySelectorAll "[#{@options.paneAttribute}]"

initialize panes

			_.each panes, @register

hide all panes to start

			(do @hideAll).then =>

remove display:none

				# do @displayBlock

then show first pane
			
				first = _.one @panes
				if first
					@show first

## Bo.displayBlock
Overrides `display:none` CSS rule that hides panes initially

		displayBlock: ->

			@iterate (pane) ->
				# pane.element.style.display = 'block'

## Bo.register
`{String|Number|DOMElement} element`
Register panes from the DOM

		register: (element) =>

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
			Promise.all (
				Object
					.keys(@panes)
					.map((_) => @panes[_])
					.map (_) -> _.right instant: yes
			)

## Bo.show
`{Number|String} id`
Slides in the pane with the given `id`

		show: (id) ->

			# hide active pane
			newPane = @panes[id]
			oldPane = @model.get 'active'

			unless newPane
				throw new ReferenceError 'Pane with ID "' + id + '" does not exist in the DOM, or is not registered with Bo.'

			if oldPane

				index = newPane.index

				# slide left
				if index > oldPane.index
					
					newPane
						.right(instant: yes)
						.then ->
							Promise.all [
								do oldPane.left
								do newPane.show
							]

				# slide right
				else
					
					newPane
						.left(instant: yes)
						.then ->
							Promise.all [
								do oldPane.right
								do newPane.show
							]

			# first call, just show this pane
			else
				newPane.show instant: yes

			# register it
			@model.set 'active', newPane

## Bo.click
{Event} event
Click handler, activates a pane when its trigger is clicked

		click: (event) =>

			id = event.target.getAttribute @options.paneTriggerAttribute

			if id

				do event.preventDefault

				@show id