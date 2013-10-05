# bomobile

a small framework for authoring mobile apps with native-like performance. full unit test coverage.

## usage

### `Bo.Pane options`

```coffee
# everything is optional, otherwise uses sensible defaults
options =
	element: document.getElementById 'myPane'
	html: 'some content for my <strong>sweet</strong> new pane'
	id: 'yeOldePane'
```


### `Bo.Util`

#### each
functional, generic iterator

```coffee
# {Array|Object} collection, {function} fn
Util.each collection, (value, key) -> ...
```

#### extend
augment an object with one or more other objects

```coffee
# {Object} obj, ...
Util.extend object, secondObject, thirdObject, fourthObject
```

#### fluent
make any function return `this` for easy functional style chainability

```coffee
# {function} fn
Util.fluent fn
```

#### one
return the first key in an object (order not guaranteed, as objects are automatically sorted by key in some browsers)

```coffee
# {Object} obj
Util.one obj
```