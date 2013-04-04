var Application = Application || {};

if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Application
	Application = global.Application
}

(function(){
	"use strict";

	Application.LoadDialogView = Backbone.Dialog.extend({
		el: "#loadDialog",
		events: {
			"dragenter div.well": "onDragEnter",
			"dragover div.well": "onDragOver",
			"dragleave div.well": "onDragLeave",
			"drop div.well": "onDrop",
			"click #upload": "onUpload"
		},
		initialize: function(options) {
			Backbone.Dialog.prototype.initialize.apply(this, arguments);
			if(this.collection) this.collection.on("remove", this.render, this);
		},
		render: function(){
			this.$("table tbody").empty();
			this.collection.each(function(storageItem){
				var itemView = new Application.StorageItemView({ model: storageItem});

				itemView.on("loadStorageItem", function(storageItem){
					this._loadFromString(storageItem.get("value"));
					this.$el.modal("hide");
				}, this);

				itemView.on("removeStorageItem", function(storageItem){
					this.storage.remove(storageItem);
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
			this.storage.updateWorldFromJSON(this.world, jsonWorld);
		}
	});
})();