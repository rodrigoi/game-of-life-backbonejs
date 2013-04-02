var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var Backbone = Backbone || require("backbone");

	module.exports = Application;
}

(function(){
	"use strict";

	Application.LoadDialogView = Backbone.View.extend({
		el: "#loadDialog",
		worldCollection: null,
		events: {
			"dragenter div.well": "onDragEnter",
			"dragover div.well": "onDragOver",
			"dragleave div.well": "onDragLeave",
			"drop div.well": "onDrop",
			"click #upload": "onUpload"
		},
		initialize: function(options){
			options || (options = {});
		},
		render: function(){
			this.$("table tbody").empty();
			this.collection.each(function(storageItem){
				var itemView = new Application.StorageItemView({ model: storageItem});

				itemView.on("loadStorageItem", function(storageItem){
					this._loadFromString(storageItem.get("value"));
					this.$el.modal("hide");
				}, this);

				this.$("table tbody").append(itemView.render().el);
			}, this);

			this.$el.modal("show");
			return this;
		},
		onDragEnter:function(e){
			e.preventDefault();
			this.$(".well").css("border", "dashed 1px green");
		},
		onDragOver: function(e){
			e.preventDefault();
		},
		onDragLeave: function(e){
			e.preventDefault();
			this.$(".well").css("border", "");
		},
		onDrop: function(e){
			e.preventDefault();
			this.$(".well").css("border", "");

			var reader = new FileReader();
			var _that = this;

			reader.onload = function(e){
				_that._loadFromString(e.target.result);
				_that.$el.modal("hide");
			};
			reader.readAsText(e.originalEvent.dataTransfer.files[0]);
		},
		onUpload: function(){
			var text = this.$("input[type=text]").val();

			this._loadFromString(text);

			this.$("input[type=text]").val("");
			this.$el.modal("hide");
		},
		_loadFromString: function(jsonWorld){
			var savedData = JSON.parse(jsonWorld);
			var newWorld = new Application.World(savedData.world);

			for(var i = 0; i < newWorld.length; i++){
				var newCell = newWorld.at(i);

				var cell = this.worldCollection.at(
					newCell.get("x") + newCell.get("y") * savedData.width
				);

				if(!cell.get("alive")){
					cell.set("alive", true);
				}
			}
		}
	});
})();