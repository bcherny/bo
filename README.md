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