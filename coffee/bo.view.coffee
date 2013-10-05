define (require, exports, module) ->

	Model = require 'bo.model'
	_ = require 'bo.util'

	class View extends Model

		constructor: ->

			# events
			if @events
				_.each @events, @attachEvent

			# go for it
			if typeof @initialize is 'function'
				@initialize.apply @, arguments

		attachEvent: (type, fn) =>

			types = type.split ' '

			for t in types
				document.addEventListener t, @[fn]