var Application = Application || {};

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