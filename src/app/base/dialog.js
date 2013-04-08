var Application = Application || {};

(function(){
	"use strict";

	Backbone.Dialog = Backbone.View.extend({
		world: null,
		storage: null,
		initialize: function(options){
			options || (options = {});

			this.world = options.world || null;
			this.storage = options.storage || null;
		}
	})
})();

if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Backbone
}