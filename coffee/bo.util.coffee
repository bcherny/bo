define (require, exports, module) ->

	izzy = require 'izzy'

	Util =

		each: (collection, fn) ->

			if izzy.array collection
				for value, key in collection
					fn value, key
			else if izzy.object collection
				for key, value of collection
					fn value, key

		extend: (obj, others...) ->

			if obj and others
				for other in others
					for key of other
						obj[key] = other[key]

			obj

		fluent: (fn) ->

			->
				fn.apply @, arguments
				@

		one: (collection) ->

			return id for id of collection