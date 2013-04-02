var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var _ = _ || require("underscore");
	//var Backbone = Backbone || require("backbone");

	//the shorter the list of dependencies, the better
	Backbone = require("./base/component");
	_.extend(Application, require("./components/ticker"));
	Application.use(Backbone);
	_.extend(Application, require("./views/application"));
	//_.extend(Application, require("./collections/world"));
	//_.extend(Application, require("./views/world"));

	//if (typeof localStorage === "undefined" || localStorage === null) {
	//  var LocalStorage = require('node-localstorage').LocalStorage;
	//  localStorage = new LocalStorage('./scratch');
	//}

	module.exports = Application;
}

(function(){
	"use strict";

	_.extend(Application, {
		width: 66,
		height: 20,
		ticker: null,
		initialize: function(){
			//initialize application view
			this.ticker = new Application.Ticker();

			var applicationView = new Application.AppView({
				width: this.width,
				height: this.height
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