
expect = chai.expect

mocha.setup 'bdd'

describe 'Bo.View', ->


	spies =
		initialize: sinon.spy()
		event: sinon.spy()

	class TestView extends View
		initialize: spies.initialize
		events:
			'click': 'handler'
		handler: spies.event
	
	view = new TestView 'foo', 'bar', 'baz'
	event = new CustomEvent 'click'
	document.dispatchEvent event


	it 'should call initialize() when constructed', ->

		expect(spies.initialize.called).to.equal true

	it 'should call initialize() exactly once', ->

		expect(spies.initialize.calledOnce).to.equal true

	it 'should pass its arguments to initialize()', ->

		expect(spies.initialize.args[0]).to.deep.equal ['bar', 'baz']

	it 'should fire the corresponding event when fireEvent() is called', ->

		expect(spies.event.called).to.equal true

	it 'should fire the corresponding event exactly once when fireEvent() is called', ->

		expect(spies.event.calledOnce).to.equal true


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