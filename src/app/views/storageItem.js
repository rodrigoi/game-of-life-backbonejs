var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var _ = _ || require("underscore");
	var Backbone = Backbone || require("backbone");

	Application = require("../models/storageItem");

	module.exports = Application;
}

(function(){
	"use strict";

	Application.StorageItemView = Backbone.View.extend({
		tagName: "tr",
		template: _.template("<td><%= key %></td><td><button class=\"load btn btn-small\"><span class=\"icon-upload\"></span>Load</button></td><td><button class=\"remove btn btn-small btn-danger\"><span class=\"icon-trash\"></span>Remove</button></td>"),
		events: {
			"click .load": "onLoad",
			"click .remove": "onRemove"
		},
		render: function(){
			this.$el.html(this.template(this.model.attributes));
			return this;
		},
		onLoad: function(){
			this.trigger("loadStorageItem", this.model);
		},
		onRemove: function(){
			this.trigger("removeStorageItem", this.model);
		}
	});
})();