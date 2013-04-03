var Application = Application || {};

(function(){
	"use strict";

	Application.ControlsView = Backbone.View.extend({
		el: ".btn-toolbar",
		events: {
			"click #start": "onStart",
			"click #stop": "onStop",
			"click #next": "onNext",
			"click #clear": "onClear",
			"click #save": "onSave",
			"click #load": "onLoad",
			"click #randomize": "onRandomize",
			"click #gun": "onGun"
		},
		onStart: function(){
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
				this.trigger("konami");
			} else {
				Backbone.trigger("tick");
			}
		},
		onClear: function(){
			this.trigger("clear");
		},
		onSave:function(){
			this.trigger("save");
		},
		onLoad: function(){
			this.trigger("load");
		},
		onRandomize: function(){
			this.trigger("randomize");
		},
		onGun: function(){
			this.trigger("gun");
		}
	});
})();