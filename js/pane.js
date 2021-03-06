// Generated by CoffeeScript 1.6.3
var Pane,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Pane = (function() {
  Pane.prototype.id = null;

  Pane.prototype.element = null;

  function Pane(options) {
    var element, html, idAttr;
    this.options = options;
    this.clearAnimation = __bind(this.clearAnimation, this);
    ++this.factory.counter;
    element = this.options.element;
    html = this.options.html;
    idAttr = element ? element.getAttribute(this.options.paneAttribute) : void 0;
    this.id = this.options.id || idAttr || this.factory.id();
    this.element = element || this.factory.create();
    this.index = this.options.index || this.factory.counter;
    this.element.setAttribute(this.options.paneAttribute, this.id);
    if (html) {
      this.element.innerHTML = html;
    }
  }

  Pane.prototype.factory = {
    counter: 0,
    create: function() {
      var element;
      element = document.createElement('div');
      element.setAttribute('data-bo-pane', this.id());
      document.body.appendChild(element);
      return element;
    },
    id: function() {
      return "pane-" + this.counter;
    }
  };

  Pane.prototype.clearAnimation = function() {
    return this.element.classList.remove('animate');
  };

  Pane.prototype.animate = function(_arg) {
    var direction, instant, oppositeDirections, _ref,
      _this = this;
    _ref = _arg != null ? _arg : {
      direction: 'left',
      instant: false
    }, direction = _ref.direction, instant = _ref.instant;
    oppositeDirections = ['center', 'left', 'right'].filter(function(_) {
      return _ !== direction;
    });
    return new Promise(function(resolve) {
      var _onAfterEnd, _onEnd;
      _this.element.classList.remove('hidden');
      _onEnd = function() {
        _this.element.removeEventListener(_onEnd);
        _onAfterEnd();
        return resolve();
      };
      _onAfterEnd = function() {
        _this.element.classList.remove("animate-" + direction);
        oppositeDirections.forEach(function(_) {
          return _this.element.classList.remove(_);
        });
        _this.element.classList.add(direction);
        return _this.element.classList.add('hidden');
      };
      if (instant) {
        _onAfterEnd();
        return setTimeout(resolve, 0);
      } else {
        _this.element.classList.add("animate-" + direction);
        return _this.element.addEventListener('animationend', _onEnd, false);
      }
    });
  };

  Pane.prototype.left = function(_arg) {
    var instant;
    instant = (_arg != null ? _arg : {
      instant: false
    }).instant;
    return this.animate({
      direction: 'left',
      instant: instant
    });
  };

  Pane.prototype.right = function(_arg) {
    var instant;
    instant = (_arg != null ? _arg : {
      instant: false
    }).instant;
    return this.animate({
      direction: 'right',
      instant: instant
    });
  };

  Pane.prototype.show = function(_arg) {
    var instant;
    instant = (_arg != null ? _arg : {
      instant: false
    }).instant;
    return this.animate({
      direction: 'center',
      instant: instant
    });
  };

  return Pane;

})();
