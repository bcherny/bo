# izzy

A micro library for naive type checking

[![Build Status](https://travis-ci.org/eighttrackmind/izzy.png)](https://travis-ci.org/eighttrackmind/izzy.png)
[![browser support](https://ci.testling.com/eighttrackmind/izzy.png)](https://ci.testling.com/eighttrackmind/izzy)

## usage

```js
> izzy.string ('foo')
// > true

// or, equivalently:
> izzy ('string', 42)
// > false
```

## supported checks

array, boolean, defined, function, null, number, object, string

## size

|						|				|
|-----------------------|---------------|
| Raw					| 1283 bytes	|
| Uglified				| 681 bytes		|
| Uglified + gzipped	| 313 bytes		|

## environment support

Any browser (as `window.izzy` if you're not using a module loader), AMD, CommonJS, NodeJS

## building it yourself

```bash
npm install
grunt
```