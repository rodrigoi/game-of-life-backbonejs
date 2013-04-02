var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var jQuery = $ = jQuery || require("jquery");
	var _ = _ || require("underscore");
	var Backbone = Backbone || require("backbone");
	Backbone.$ = jQuery;

	Konami = function(){}
	module.exports = Application;
}

(function(){
	"use strict";

	Application.AppView = Backbone.View.extend({
		el: ".container",
		generation: 0,
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
		initialize: function(){
			var _that = this;
			var konami = new Konami(function(){
				_that.$("#next").addClass("wobble animated");
			});

			Backbone.on("regenerate", this.render, this);
			Backbone.on("tick", this.onTick, this);
		},
		render: function(){
			this.$("#generationCount").html(this.generation);
			return this;
		},
		onTick: function(){
			this.generation++;
			this.render();
		},
		onStart: function() {
			this.$("#start, #next, #clear, #save, #load, #randomize").attr("disabled", "disabled");
			this.$("#stop").removeAttr("disabled");
			Backbone.trigger("startTimer");
		},
		onStop: function() {
			this.$("#start, #next, #clear, #save, #load, #randomize").removeAttr("disabled");
			this.$("#stop").attr("disabled", "disabled");
			Backbone.trigger("stopTimer");
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
			this.generation = 0;
			this.render();
			Backbone.trigger("clear");
		},
		onSetTickFromSubmit: function(){
			var newSpeed = this.$("#tick").val();
			Backbone.trigger("changeSpeed", newSpeed);
			return false;
		},
		onSave: function(){
			Backbone.trigger("save");
		},
		onLoad: function(){
			Backbone.trigger("load");
		},
		onRandomize: function(){
			Backbone.trigger("randomize");
		},
		onGun: function(){

		},
		_konami: function(){
			var konami = new Application.Konami();
			konami.render();
		}
	});

})();