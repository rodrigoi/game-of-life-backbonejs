var Application = Application || {};
if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	var jQuery = require("jquery");
	var _ = _ = require("underscore");
	var Backbone = Backbone || require("backbone");

	Backbone.$ = jQuery;
	Backbone.jQuery = jQuery;

	global.Backbone = Backbone;
	global._ = _;
	global.$ = jQuery;
	global.jQuery = jQuery;

	global.Application = Application;

	_.extend(Backbone, require("./base/component"));
	_.extend(Backbone, require("./base/dialog"));

	_.extend(Application, require("./collections/storage"));
	_.extend(Application, require("./collections/world"));

	_.extend(Application, require("./components/localStorage"));
	_.extend(Application, require("./components/ticker"));

	_.extend(Application, require("./models/cell"));
	_.extend(Application, require("./models/storageItem"));

	_.extend(Application, require("./views/application"));
	_.extend(Application, require("./views/cell"));
	_.extend(Application, require("./views/controls"));
	_.extend(Application, require("./views/generationCounter"));
	_.extend(Application, require("./views/storageItem"));
	_.extend(Application, require("./views/world"));

	_.extend(Application, require("./views/dialogs/load"));
	_.extend(Application, require("./views/dialogs/save"));


	module.exports = {
		_: _,
		$: jQuery,
		Backbone: Backbone,
		Application: Application
	};
}

(function(){
	"use strict";

	_.extend(Application, {
		width: 66,
		height: 20,
		ticker: null,
		storage: null,
		initialize: function(){
			this.ticker = new Application.Ticker();

			this.storage = new Application.LocalStorage();

			var applicationView = new Application.AppView({
				width: this.width,
				height: this.height,
				storage: this.storage
			});
			applicationView.render();

			applicationView.on("start", function(){
				this.ticker.start();
			}, this);

			applicationView.on("stop", function(){
				this.ticker.stop();
			}, this);

			applicationView.on("changeSpeed", function(newSpeed){
				this.ticker.changeSpeed(newSpeed);
			}, this);
		}
	});
})()