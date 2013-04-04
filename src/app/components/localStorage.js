var Application = Application || {};

if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Application
	Application = global.Application

	var localStorage = null;
}

(function(){
	"use strict";

	Application.LocalStorage = Backbone.Component.extend({
		items: null,
		initialize: function(options){
			options || (options = {});

			if (options.localStorage) localStorage = options.localStorage

			Backbone.Component.prototype.initialize.apply(this, arguments);

			this.items = new Application.Storage();
			if(localStorage) {
				for (var i = 0, len = localStorage.length; i < len; i++){
					this.items.add(new Application.StorageItem({
						index: i,
						key: localStorage.key(i),
						value: localStorage.getItem(localStorage.key(i))
					}));
				}
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
			this.addByJson(name, this.createJSONItem(world));
		},
		remove: function(item){
			localStorage.removeItem(item.get("key"));
			this.items.remove(item);
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
		updateWorldFromJSON: function(world, json){
			var savedData = JSON.parse(json);
			this.updateWorldFromSavedData(world, savedData);
		},
		updateWorldFromSavedData: function(world, savedData){
			world.clear();
			_.each(savedData.world, function(item){
				var cell = world.at(item.x + item.y * savedData.width);

				if(cell) {
					cell.set("alive", true);
				}
			});
		}
	});
})();