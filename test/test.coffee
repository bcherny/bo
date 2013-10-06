require.config
	paths:
		izzy: '../node_modules/izzy/izzy'

define (require, module, exports) ->

	Model = require '../js/bo.model'
	Util = require '../js/bo.util'
	expect = chai.expect

	mocha.setup 'bdd'

	describe 'Bo.Model', ->


		it 'should have a get method', ->

			model = new Model
			expect(model).to.have.property 'get'


		it 'should have a set method', ->

			model = new Model
			expect(model).to.have.property 'set'


		it 'should persist when set', ->

			model = new Model
			key = 'foo'
			value = 'bar'
			model.set key, value
			expect(model.data[key]).to.equal value


		it 'gotten data should not mutate after being set', ->

			model = new Model
			key = 'foo'
			value = 'bar'
			model.set key, value
			expect(model.get(key)).to.equal value


		it 'gotten data should reflect the current model state', ->

			model = new Model
			key = 'foo'
			value = 'bar'
			value2 = 'bar2'
			model.set key, value
			model.set key, value2
			expect(model.get(key)).to.equal value2


	describe 'Bo.Util', ->

		describe '#each', ->

			it 'should iterate over arrays', ->

				collection = [10...21]
				sums =
					keys: 0
					values: 0

				accumulate = (value, key) ->
					sums.keys += key
					sums.values += value

				expected =
					keys: 55
					values: 165

				Util.each collection, accumulate

				expect(sums).to.deep.equal expected

			it 'should iterate over objects', ->

				collection =
					10: 0
					11: 1
					12: 2
					13: 3
					14: 4
					15: 5
					16: 6
					17: 7
					18: 8
					19: 9
					20: 10
				sums =
					keys: 0
					values: 0

				accumulate = (value, key) ->
					sums.keys += +key
					sums.values += value

				expected =
					keys: 165
					values: 55

				Util.each collection, accumulate

				expect(sums).to.deep.equal expected


		describe '#extend', ->

			it 'should extend one object with 1 other object', ->

				one = foo: 5
				two = bar: 6
				expected =
					foo: 5
					bar: 6
				result = Util.extend one, two

				expect(result).to.deep.equal expected

			it 'should extend one object with >1 other objects', ->

				one = foo: 5
				two = bar: 6
				three = baz: 7
				expected =
					foo: 5
					bar: 6
					baz: 7
				result = Util.extend one, two, three

				expect(result).to.deep.equal expected


		describe '#fluent', ->

			it 'should return `this`', ->

				fn = ->
				fluent = Util.fluent fn
				result = fluent.call @

				expect(result).to.equal(@)


		describe '#one', ->

			it 'should return the first key of an object', ->

				obj =
					foo: 5
					bar: 6
				result = Util.one obj

				expect(result).to.equal 'foo'


	mocha.run()