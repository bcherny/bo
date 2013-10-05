define (require, exports, module) ->

	Model = require 'bo.model'
	_ = require 'bo.util'

	class View extends Model

		constructor: ->

			# events
			_.each @events, @attachEvent

			# go for it
			@initialize.apply @, arguments

		attachEvent: (type, fn) =>

			types = type.split ' '

			for t in types
				document.addEventListener t, @[fn]