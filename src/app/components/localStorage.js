var Application = Application || {};

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
		addJson: function(json, name) {
			localStorage.setItem(name, json);
		},
		addWorld: function(world, name){
			localStorage.setItem(name, this.createJSONItem(world));
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
		}
	});
})();