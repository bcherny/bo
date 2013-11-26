# bo

a small (1.6k gzipped) mvv framework for authoring mobile apps with native-like performance. full unit test coverage.

![screenshot](http://i.imgur.com/BsOUdah.png)

## demo

http://eighttrackmind.github.io/bo/demo/

## what?

- barebones mvv (fully tested)
- smooth paging and sliding animation

## api

### html

- `<div data-bo-pane="foo">...</div>` - set a pane's ID to `foo` (works with any tag, not just `div`)
- `<a data-bo-trigger-pane="foo">...</div>` - slide to the pane with ID `foo` when clicked/tapped (works with any tag, not just `a`)

### coffee (or js if you prefer)

see https://github.com/eighttrackmind/bo/tree/master/coffee

## usage

Put your pages into a single HTML file. Each pane ("screen") should have a unique `data-bo-pane` attribute. To trigger another pane when clicked/tapped, give the trigger a `data-bo-trigger-pane` attribute.

```html
<div data-bo-pane="paneId">
	<h1>Hello world!</h1>

	...

	<button data-bo-trigger-pane="anotherPaneId">Next</button>
</div>
```

Link to `bo.css` in your `<head>`.

```html
<html>
<head>
	...
	<link rel="stylesheet" href="bo.css" />
</head>
<body>
	...
</body>
</html>
```

Install and link to dependencies at the bottom of your `<body>`.

```bash
npm install
```

```html
<html>
<head>
	...
	<link rel="stylesheet" href="bo.css" />
</head>
<body>
	...
	<script src="node_modules/izzy/izzy.js"></script>
	<script src="node_modules/umodel/umodel.js"></script>
</body>
</html>
```

Link to `bo.js` at the bottom of your `<body>`, after the dependencies.

```html
<html>
<head>
	...
	<link rel="stylesheet" href="bo.css" />
</head>
<body>
	...
	<script src="node_modules/izzy/izzy.js"></script>
	<script src="node_modules/umodel/umodel.js"></script>
	<script src="bo.js"></script>
</body>
</html>
```

## building it yourself

```bash
npm install
grunt
```