var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var jQuery = $ = jQuery || require("jquery");
	var _ = _ || require("underscore");
	var Backbone = Backbone || require("backbone");
	Backbone.$ = jQuery;

	_.extend(Application, require("../collections/storage"));

	_.extend(Application, require("./generationCounter"));
	_.extend(Application, require("./world"));
	_.extend(Application, require("./controls"));
	_.extend(Application, require("./dialogs/save"));
	_.extend(Application, require("./dialogs/load"));

	module.exports = Application;

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
			"submit #setTickForm": "onSetTickFromSubmit"
		},
		initialize: function(options){
			options || (options = {});
			this.storage = options.storage || {};

			this.initializeChildren(options);
			this.initializeDialogs(options);
			this.initializeControls(options);

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
				collection: this.storage.items,
				world: worldView.collection,
				storage: this.storage
			});
			loadView.worldCollection = worldView.collection;
			loadView.listenTo(this, "load", loadView.render)
			this.dialogs.push(loadView);
		},
		initializeControls: function(options){
			var controls = new Application.ControlsView();

			_.each(["start", "stop", "clear", "save", "load", "randomize"], function(event){
				controls.on(event, function(){ this.trigger(event); }, this);
			}, this);

			controls.on("konami", this._konami, this);
			controls.on("gun", this.onGun, this);

			this.children.push(controls);
		},
		render: function(){
			_.each(this.children, function(child){
				child.render();
			});
			return this;
		},
		onSetTickFromSubmit: function(e){
			var newSpeed = this.$("#tick").val();
			this.trigger("changeSpeed", newSpeed);
			return false;
		},
		onGun: function(){
			var worldView = this.children[1] || {};
			this.storage.updateWorldFromSavedData(worldView.collection, Application.Data.Gun);
		},
		_konami: function(){
			var konami = new Application.Konami();
			konami.render();
		}
	});
})();