// Generated by CoffeeScript 1.6.3
(function() {
  define(function(require, module, exports) {
    var Model, Util, expect;
    Model = require('../js/bo.model');
    Util = require('../js/bo.util');
    expect = chai.expect;
    mocha.setup('bdd');
    describe('Bo.Model', function() {
      it('should have a get method', function() {
        var model;
        model = new Model;
        return expect(model).to.have.property('get');
      });
      it('should have a set method', function() {
        var model;
        model = new Model;
        return expect(model).to.have.property('set');
      });
      it('should persist when set', function() {
        var key, model, value;
        model = new Model;
        key = 'foo';
        value = 'bar';
        model.set(key, value);
        return expect(model.data[key]).to.equal(value);
      });
      it('gotten data should not mutate after being set', function() {
        var key, model, value;
        model = new Model;
        key = 'foo';
        value = 'bar';
        model.set(key, value);
        return expect(model.get(key)).to.equal(value);
      });
      return it('gotten data should reflect the current model state', function() {
        var key, model, value, value2;
        model = new Model;
        key = 'foo';
        value = 'bar';
        value2 = 'bar2';
        model.set(key, value);
        model.set(key, value2);
        return expect(model.get(key)).to.equal(value2);
      });
    });
    describe('Bo.Util', function() {
      describe('#each', function() {
        it('should iterate over arrays', function() {
          var accumulate, collection, expected, sums;
          collection = [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
          sums = {
            keys: 0,
            values: 0
          };
          accumulate = function(value, key) {
            sums.keys += key;
            return sums.values += value;
          };
          expected = {
            keys: 55,
            values: 165
          };
          Util.each(collection, accumulate);
          return expect(sums).to.deep.equal(expected);
        });
        return it('should iterate over objects', function() {
          var accumulate, collection, expected, sums;
          collection = {
            10: 0,
            11: 1,
            12: 2,
            13: 3,
            14: 4,
            15: 5,
            16: 6,
            17: 7,
            18: 8,
            19: 9,
            20: 10
          };
          sums = {
            keys: 0,
            values: 0
          };
          accumulate = function(value, key) {
            sums.keys += +key;
            return sums.values += value;
          };
          expected = {
            keys: 165,
            values: 55
          };
          Util.each(collection, accumulate);
          return expect(sums).to.deep.equal(expected);
        });
      });
      describe('#extend', function() {
        it('should extend one object with 1 other object', function() {
          var expected, one, result, two;
          one = {
            foo: 5
          };
          two = {
            bar: 6
          };
          expected = {
            foo: 5,
            bar: 6
          };
          result = Util.extend(one, two);
          return expect(result).to.deep.equal(expected);
        });
        return it('should extend one object with >1 other objects', function() {
          var expected, one, result, three, two;
          one = {
            foo: 5
          };
          two = {
            bar: 6
          };
          three = {
            baz: 7
          };
          expected = {
            foo: 5,
            bar: 6,
            baz: 7
          };
          result = Util.extend(one, two, three);
          return expect(result).to.deep.equal(expected);
        });
      });
      describe('#fluent', function() {
        return it('should return `this`', function() {
          var fluent, fn, result;
          fn = function() {};
          fluent = Util.fluent(fn);
          result = fluent.call(this);
          return expect(result).to.equal(this);
        });
      });
      return describe('#one', function() {
        return it('should return the first key of an object', function() {
          var obj, result;
          obj = {
            foo: 5,
            bar: 6
          };
          result = Util.one(obj);
          return expect(result).to.equal('foo');
        });
      });
    });
    return mocha.run();
  });

}).call(this);
