Conway's Game of Life
===

JavaScript Versions
---

### Backbone.JS Implementation

This folder contains the Backbone.JS implementation of Conway's Game of Life. If your editor supports the [editorconfig.org](http://editorconfig.org) standard, take a look ar the .editorconfig file. It's configured to use tabs as indent characters, and to set them two spaces long. Because I fancy that.

To run the samples, you need to use [bower](http://twitter.github.com/bower/) to download the components. For that, you need [Node Package Manager](https://npmjs.org/). Run these commands on the root folder:

	$ npm install
	$ bower install
	$ npm start

Dependencies will be loaded and a browser will start pointing to the index.html on the src folder.
To run the tests, simply run

	$ mocha

on the root folder. That will run the mocha command line runner using the mocha.opts file on the test folder.

![image](https://raw.github.com/rodrigoi/dojo/master/Conways-Game-of-Life/JavaScript/BackboneJS/docs/grid.PNG)

Have fun, and enjoy your burrito ;)