var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var _ = _ || require("underscore");
	//var Backbone = Backbone || require("backbone");

	//the shorter the list of dependencies, the better
	Backbone = require("./base/component");
	_.extend(Application, require("./components/ticker"));
	Application.use(Backbone);
	_.extend(Application, require("./views/application"));
	_.extend(Application, require("./collections/world"));
	_.extend(Application, require("./views/world"));

	if (typeof localStorage === "undefined" || localStorage === null) {
	  var LocalStorage = require('node-localstorage').LocalStorage;
	  localStorage = new LocalStorage('./scratch');
	}

	module.exports = Application;
}

(function(){
	"use strict";

	_.extend(Application, {
		width: 66,
		height: 20,
		ticker: null,
		worldView: null,
		initialize: function(){
			//initialize application view
			this.ticker = new Application.Ticker();

			var applicationView = new Application.AppView();
			applicationView.render();

			//initialize world view
			this.worldView = new Application.WorldView({
				collection: new Application.World(null, {
					width: this.width,
					height: this.height
				})
			});
			this.worldView.render();

			Backbone.on("save", this.save, this);
			Backbone.on("load", this.load, this);
			Backbone.on("randomize", this.randomize, this);
		},
		save: function(){
			var saveView = new Application.SaveDialogView({
				collection: this.worldView.collection
			});
			saveView.render();
		},
		load: function(){
			var storageItems = new Application.Storage();
			for (var i = 0, len = localStorage.length; i < len; i++){
				storageItems.add(new Application.StorageItem({
					index: i,
					key: localStorage.key(i),
					value: localStorage.getItem(localStorage.key(i))
				}));
			}

			var loadView = new Application.LoadDialogView({ collection: storageItems });
			loadView.worldView = this.worldView;
			loadView.render();
		},
		randomize: function(){
			this.worldView.collection.randomize();
		}
	});

})();