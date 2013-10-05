define (require, exports, module) ->

	izzy = require 'izzy'
	Model = require 'bo.model'
	_ = require 'bo.util'

	class View extends Model

		constructor: ->

			# events
			if izzy.object @events
				_.each @events, @attachEvent

			# go for it
			if izzy.function @initialize
				@initialize.apply @, arguments

		attachEvent: (fn, type) =>

			types = type.split ' '

			for t in types
				document.addEventListener t, @[fn]