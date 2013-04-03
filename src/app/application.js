var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var _ = _ || require("underscore");

	//the shorter the list of dependencies, the better
	Backbone = require("./base/component");

	_.extend(Application, require("./components/ticker"));
	Application.use(Backbone);

	_.extend(Application, require("./components/localStorage"));
	Application.use(Backbone);
	_.extend(Application, require("./views/application"));

	module.exports = Application;
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
})();