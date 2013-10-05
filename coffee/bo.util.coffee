define (require, exports, module) ->

	Util =

		each: (collection, fn) ->

			if collection.length
				for value, key in collection
					fn value, key
			else
				for key, value of collection
					fn value, key

		extend: (obj, others...) ->

			if !obj
				throw new TypeError 'extend expects argument 0 to be an Object'

			if others
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