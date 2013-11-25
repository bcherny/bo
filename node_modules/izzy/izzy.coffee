# helper
extend = (a, b) ->
	for key of b
		a[key] = b[key]
	a

# type check functions
types =

	array: (thing) ->

		not izzy.string(thing) and not izzy.number(thing) and izzy.object(thing) and izzy.defined(thing.length)

	boolean: (thing) ->

		typeof thing is 'boolean'

	defined: (thing) ->

		thing isnt undefined

	function: (thing) ->

		typeof thing is 'function'

	null: (thing) ->

		thing is null

	number: (thing) ->

		typeof thing is 'number'

	object: (thing) ->

		typeof thing is 'object'

	string: (thing) ->

		typeof thing is 'string'

# accept both dot and argument notation
izzy = (type, thing) ->

	if types.defined types[type]
		types[type] thing
	else
		undefined

extend izzy, types