var Application = Application || {};

(function(){
	"use strict";

	Application.LoadDialogView = Backbone.View.extend({
		el: "#loadDialog",
		worldView: null,
		events: {
			"dragenter div.well": "onDragEnter",
			"dragover div.well": "onDragOver",
			"dragleave div.well": "onDragLeave",
			"drop div.well": "onDrop",
			"click #upload": "onUpload"
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
			var newWorld = new Application.World(JSON.parse(jsonWorld).world);

			for(var i = 0; i < this.worldView.collection.length; i++){
				var cell = this.worldView.collection.at(i);
				var newCellValue = newWorld.at(i).get("alive");
				if(cell.get("alive") !== newCellValue){
					cell.set("alive", newCellValue);
				}
			}
		}
	});
})();