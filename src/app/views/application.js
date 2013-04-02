var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var jQuery = $ = jQuery || require("jquery");
	var _ = _ || require("underscore");
	var Backbone = Backbone || require("backbone");
	Backbone.$ = jQuery;

	_.extend(Application, require("../collections/storage"));

	_.extend(Application, require("./generationCounter"));
	_.extend(Application, require("./world"));
	_.extend(Application, require("./saveDialog"));
	_.extend(Application, require("./loadDialog"));

	module.exports = Application;

	if (typeof localStorage === "undefined" || localStorage === null) {
		var LocalStorage = require('node-localstorage').LocalStorage;
		localStorage = new LocalStorage('./scratch');
	}

	Konami = function(){}
}

(function(){
	"use strict";

	Application.AppView = Backbone.View.extend({
		el: ".container",
		children: [],
		dialogs: [],
		storage: null,
		events: {
			"click #start": "onStart",
			"click #stop": "onStop",
			"click #next": "onNext",
			"click #clear": "onClear",
			"submit #setTickForm": "onSetTickFromSubmit",
			"click #save": "onSave",
			"click #load": "onLoad",
			"click #randomize": "onRandomize",
			"click #gun": "onGun"
		},
		initialize: function(options){
			options || (options = {});
			this.storage = options.storage || {};

			this.initializeChildren(options);
			this.initializeDialogs(options);

			var _that = this;
			var konami = new Konami(function(){
				_that.$("#next").addClass("wobble animated");
			});
		},
		initializeChildren: function(options){
			var generationCounterView = new Application.GenerationCounterView();
			this.children.push(generationCounterView);
			generationCounterView.listenTo(this, "clear", generationCounterView.clear)

			var worldView = new Application.WorldView(options);
			this.children.push(worldView);
			worldView.listenTo(this, "randomize", worldView.randomize);
			worldView.listenTo(this, "clear", worldView.clear)
		},
		initializeDialogs: function(options){
			var worldView = this.children[1] || {};

			var saveView = new Application.SaveDialogView({
				world: worldView.collection,
				storage: this.storage
			});
			this.dialogs.push(saveView);
			saveView.listenTo(this, "save", saveView.render);

			var loadView = new Application.LoadDialogView({
				collection: this.storage.storageItems()
			});
			loadView.worldCollection = worldView.collection;
			loadView.listenTo(this, "load", loadView.render)
			this.dialogs.push(loadView);

		},
		render: function(){
			_.each(this.children, function(child){
				child.render();
			});
			return this;
		},
		onStart: function() {
			this.$("#start, #next, #clear, #save, #load, #randomize").attr("disabled", "disabled");
			this.$("#stop").removeAttr("disabled");
			this.trigger("start");
		},
		onStop: function() {
			this.$("#start, #next, #clear, #save, #load, #randomize").removeAttr("disabled");
			this.$("#stop").attr("disabled", "disabled");
			this.trigger("stop");
		},
		onNext: function(){
			var nextButton = this.$("#next");
			if(nextButton.hasClass("animated")){
				nextButton.removeClass("animated");
				this._konami();
			} else {
				Backbone.trigger("tick");
			}
		},
		onClear: function(){
			this.trigger("clear");
		},
		onSetTickFromSubmit: function(e){
			var newSpeed = this.$("#tick").val();
			this.trigger("changeSpeed", newSpeed);
			return false;
		},
		onSave: function(){
			this.trigger("save");
		},
		onLoad: function(){
			this.trigger("load");
		},
		onRandomize: function(){
			this.trigger("randomize");
		},
		onGun: function(){
			console.log(Application.Data.Gun.world);
		},
		_konami: function(){
			var konami = new Application.Konami();
			konami.render();
		}
	});

})();