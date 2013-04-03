var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var Backbone = Backbone || require("backbone");

	module.exports = Application;
}

(function(){
	"use strict";

	Application.Dialog = Backbone.View.extend({
		world: null,
		storage: null,
		initialize: function(options){
			options || (options = {});

			if (options.world) this.world = options.world;
			if (options.storage) this.storage = options.storage;
		}
	})
})();