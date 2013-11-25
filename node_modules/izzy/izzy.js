(function(root, factory) {
    if(typeof exports === 'object') {
        module.exports = factory();
    }
    else if(typeof define === 'function' && define.amd) {
        define('izzy', [], factory);
    }
    else {
        root.izzy = factory();
    }
}(this, function() {
var extend, izzy, types;

extend = function(a, b) {
  var key;
  for (key in b) {
    a[key] = b[key];
  }
  return a;
};

types = {
  array: function(thing) {
    return !izzy.string(thing) && !izzy.number(thing) && izzy.object(thing) && izzy.defined(thing.length);
  },
  boolean: function(thing) {
    return typeof thing === 'boolean';
  },
  defined: function(thing) {
    return thing !== void 0;
  },
  "function": function(thing) {
    return typeof thing === 'function';
  },
  "null": function(thing) {
    return thing === null;
  },
  number: function(thing) {
    return typeof thing === 'number';
  },
  object: function(thing) {
    return typeof thing === 'object';
  },
  string: function(thing) {
    return typeof thing === 'string';
  }
};

izzy = function(type, thing) {
  if (types.defined(types[type])) {
    return types[type](thing);
  } else {
    return void 0;
  }
};

extend(izzy, types);

    return izzy;
}));
