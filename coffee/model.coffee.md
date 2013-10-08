# Bo.Model

	define 'model', ->

		class Model

			data: {}

## Model.get
{String|Number} key

			get: (key) ->

				@data[key]

## Model.set
{String|Number} key, {Mixed} value

			set: (key, value) ->

				@data[key] = value

## Model.push
{String|Number} key, {Mixed} value, {String|Number} index

			push: (key, value, index) ->

				array = @data[key] or (@data[key] = {})

				if index

					array[+index] = value

				else

					array.push value