# Bo.Util

Basic, underscore-like utilities. But smaller, and modern mobile only.

	define 'util', ->

		izzy = require 'izzy'
		
		util =

## Util.each
functional, generic iterator

			each: (collection, fn) ->

				if izzy.array collection
					for value, key in collection
						fn value, key
				else if izzy.object collection
					for key, value of collection
						fn value, key

## Util.extend
augment an object with one or more other objects

			extend: (obj, others...) ->

				if obj and others
					for other in others
						for key of other
							obj[key] = other[key]

				obj

## Util.fluent
make any function return `this` for easy functional style chainability

			fluent: (fn) ->

				->
					fn.apply @, arguments
					@

## Util.one
return the first key in an object (order not guaranteed, as objects are automatically sorted by key in some browsers)

			one: (collection) ->

				return id for id of collection