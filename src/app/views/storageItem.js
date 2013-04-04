var Application = Application || {};

if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Application
	Application = global.Application
}

(function(){
	"use strict";

	Application.StorageItemView = Backbone.View.extend({
		tagName: "tr",
		template: _.template("<td><%= key %></td><td><button class=\"load btn btn-small btn-success\"><span class=\"icon-upload\"></span>Load</button></td><td><button class=\"remove btn btn-small btn-danger\"><span class=\"icon-trash\"></span>Remove</button></td>"),
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