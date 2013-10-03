define (require, exports, module) ->

	Bo = require 'bo'

	Bo.Util =

		each: (collection, fn) ->
			if collection.length
				for value, key in collection
					fn value, key
			else
				for value, key of collection
					fn value, key

		extend: (one, two) ->
			for key, val of two
				one[key] = two[key]
			one

		fluent: (fn) ->
			->
				fn.apply @, arguments
				@

		one: (obj) ->
			return id for id of obj