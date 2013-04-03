var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var _ = _ || require("underscore");
	var Backbone = Backbone || require("backbone");

	Application = require("../collections/storage");

	module.exports = Application

	module.exports.use = function(Backbone){
		Backbone = Backbone
	}
}

(function(){
	"use strict";

	Application.LocalStorage = Backbone.Component.extend({
		items: null,
		initialize: function(){
			Backbone.Component.prototype.initialize.apply(this, arguments);

			this.items = new Application.Storage();
			for (var i = 0, len = localStorage.length; i < len; i++){
				this.items.add(new Application.StorageItem({
					index: i,
					key: localStorage.key(i),
					value: localStorage.getItem(localStorage.key(i))
				}));
			}
		},
		storageItems: function(){
			return this.items;
		},
		addByJson: function(name, json) {
			localStorage.setItem(name, json);
			this.items.add(new Application.StorageItem({
				key: name,
				value: json
			}))
		},
		addByWorld: function(name, world){
			this.addByJson(this.createJSONItem(world), name);
		},
		createJSONItem: function(world) {
			if(world){
				return JSON.stringify({
					world: world.where({ alive: true }).map(function(item){
						return {
							x: item.get("x"),
							y: item.get("y")
						};
					}),
					width: world.width,
					height: world.height,
					type: "world"
				});
			}
		},
		remove: function(item){
			localStorage.removeItem(item.get("key"));
			this.items.remove(item);
		},
		updateWorldFromSavedData: function(world, savedData){
			world.clear();
			_.each(savedData.world, function(item){
				var cell = world.at(item.x + item.y * savedData.width);

				if(cell) {
					cell.set("alive", true);
				}
			});
		},
		updateWorldFromJSON: function(world, json){
			var savedData = JSON.parse(json);
			this.updateWorldFromSavedData(savedData);
		}
	});
})();