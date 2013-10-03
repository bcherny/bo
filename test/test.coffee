define (require, module, exports) ->

	Model = require '../js/bo.model'
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


	mocha.run()