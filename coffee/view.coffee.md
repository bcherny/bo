# A simple view class for Bo

	define 'view', ->

		izzy = require 'izzy'
		Model = require 'model'
		_ = require 'util'

		class View extends Model

## API

If you've used Backbone you will find this syntax familiar. It's a small subset of backbone's functionality.

### View.element

			element: document

### View.events

A Backbone-style hashmap of events and handlers. For example, `'hover': 'handler'` would trigger `View.handler` when the `hover` event is triggered. Multiple triggers are supported as well, for example `'click touchstart': 'handler2'` would trigger `View.handler2` on both `touchstart` and `click`. Note that event delegation should be handled manually, within your handler functions.

			events: {}

### View.initialize

A function called after the view is constructed and events are attached.

			initialize: ->

### View internals

			constructor: (element, args...) ->

				# element
				if element instanceof Element
					@element = element

				# events
				if izzy.object @events
					_.each @events, @attachEvent

				# go for it
				if izzy.function @initialize
					@initialize.apply @, args

			attachEvent: (fn, type) =>

				types = type.split ' '

				for t in types
					@element.addEventListener t, @[fn]