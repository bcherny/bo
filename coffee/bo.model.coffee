define (require, exports, module) ->

	class Model

		data: {}

		# {String|Number} key
		get: (key) ->

			@data[key]

		# {String|Number} key, {Mixed} value
		set: (key, value) ->

			@data[key] = value