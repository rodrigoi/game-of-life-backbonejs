var Application = Application || {};

if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Application
	Application = global.Application

	Konami = function(){};
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

			this.storage = new Application.Storage();
			this.storage.fetch();

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
			generationCounterView.listenTo(this, "clear", generationCounterView.clear);
			this.children.push(generationCounterView);

			var worldView = new Application.WorldView(options);
			worldView.listenTo(this, "randomize", worldView.randomize);
			worldView.listenTo(this, "clear", worldView.clear)
			this.children.push(worldView);
		},
		initializeDialogs: function(options){
			var worldView = this.children[1] || {};

			var saveView = new Application.SaveDialogView({
				world: worldView.collection,
				storage: this.storage
			});
			saveView.listenTo(this, "save", saveView.render);
			this.dialogs.push(saveView);

			var loadView = new Application.LoadDialogView({
				world: worldView.collection,
				storage: this.storage
			});
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
			controls.on("bigun", this.onBiGun, this);

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
		onBiGun: function(){
			var worldView = this.children[1] || {};
			this.storage.updateWorldFromSavedData(worldView.collection, Application.Data.BiGun);
		},
		_konami: function(){
			var konami = new Application.Konami();
			konami.render();
		}
	});
})();