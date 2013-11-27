# bo

a small (1.6k gzipped) mvv framework for authoring mobile apps with native-like performance. full unit test coverage.

![screenshot](http://i.imgur.com/BsOUdah.png)

## demo

http://eighttrackmind.github.io/bo/demo/

## what?

- barebones mvv (fully tested)
- smooth paging and sliding animation

## usage

### html

- `<div bo-pane="foo">...</div>` - set a pane's ID to `foo` (works with any tag, not just `div`)
- `<a bo-trigger="foo">...</div>` - slide to the pane with ID `foo` when clicked/tapped (works with any tag, not just `a`)

### coffee (or js if you prefer)

see https://github.com/eighttrackmind/bo/tree/master/coffee

## usage

Put your pages into a single HTML file. Each pane ("screen") should have a unique `data-bo-pane` attribute. To trigger another pane when clicked/tapped, give the trigger a `data-bo-trigger-pane` attribute.

```html
<div bo-pane="paneId">
	<button bo-trigger="anotherPaneId">Next</button>
</div>
```

Link to `bo.css` in your `<head>`:

```html
...
<head>
	<link rel="stylesheet" href="bo.css" />
...
```

Then install dependencies:

```bash
npm install
```

Finally, link to dependencies followed by `bo.js` at the bottom of your `<body>`:

```html
	...
	<script src="node_modules/izzy/izzy.js"></script>
	<script src="node_modules/umodel/umodel.js"></script>
	<script src="bo.js"></script>
</body>
```

## api

```coffee
# create a new Bo instance
bo = new Bo
```

| Method		| Arguments					| Description  							| Example						|
|---------------|---------------------------|---------------------------------------|-------------------------------|
| `on`			| `"event1...", handler`	| Attach a DOM event listener			| `bo.on "mousedown touchstart", (event) -> ... ` |
| `register`	| `DOMElement`				| Register a DOM Element as a Bo pane	| `bo.register document.querySelector "#id"` |
| `hideAll`		| -							| Hide all Bo panes						| `do bo.hideAll`				|
| `show`		| `"id"`					| Show pane with the given ID			| `bo.show "myPaneId"`			|

## building it yourself

```bash
npm install
grunt
```