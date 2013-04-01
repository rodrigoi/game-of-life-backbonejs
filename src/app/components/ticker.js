var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var _ = _ || require("underscore");
	var Backbone = Backbone || require("backbone");

	module.exports = Application
	//very basic dependency injection, since in this case
	//Backbone must be shared with the test
	module.exports.use = function(Backbone){
		Backbone = Backbone
	}
}

(function(){
	"use strict";

	Application.Ticker = Backbone.Component.extend({
		tick: 50,
		timer:null,
		initialize: function(){
			Backbone.Component.prototype.initialize.apply(this, arguments);

			Backbone.on("startTimer", this.onStartTimer, this);
			Backbone.on("stopTimer", this.onStopTimer, this);
			Backbone.on("changeSpeed", this.onChangeSpeed, this);
		},
		onStartTimer: function(){
			if(!this.timer){
				this.timer = setInterval(this.onTick, this.tick)
			}
		},
		onStopTimer: function(){
			if(this.timer){
				this.timer = clearInterval(this.timer);
			}
		},
		onChangeSpeed: function(newSpeed){
			this.tick = newSpeed;
			if(this.timer){
				this.onStopTimer()
				this.onStartTimer()
			}
		},
		onTick: function(){
			Backbone.trigger("tick");
		}
	});
})();