// Generated by CoffeeScript 1.6.3
var _,
  __slice = [].slice;

_ = {
  each: function(collection, fn) {
    var key, value, _i, _len, _results, _results1;
    if (izzy.array(collection)) {
      _results = [];
      for (key = _i = 0, _len = collection.length; _i < _len; key = ++_i) {
        value = collection[key];
        _results.push(fn(value, key));
      }
      return _results;
    } else if (izzy.object(collection)) {
      _results1 = [];
      for (key in collection) {
        value = collection[key];
        _results1.push(fn(value, key));
      }
      return _results1;
    }
  },
  extend: function() {
    var key, obj, other, others, _i, _len;
    obj = arguments[0], others = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    if (obj && others) {
      for (_i = 0, _len = others.length; _i < _len; _i++) {
        other = others[_i];
        for (key in other) {
          obj[key] = other[key];
        }
      }
    }
    return obj;
  },
  fluent: function(fn) {
    return function() {
      fn.apply(this, arguments);
      return this;
    };
  },
  one: function(collection) {
    var id;
    for (id in collection) {
      return id;
    }
  }
};
