var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var Backbone = Backbone || require("backbone");

	module.exports = Application;
}

(function(){
	"use strict";

	Application.SaveDialogView = Backbone.View.extend({
		el: "#saveDialog",
		world: null,
		storage: null,
		json: "",
		events: {
			"click #download": "onDownload",
			"click #saveToLocalStorage": "onSaveToLocalStorage"
		},
		initialize: function(options){
			options || (options = {});

			if (options.world) this.world = options.world;
			if (options.storage) this.storage = options.storage;
		},
		render: function(){
			this.json = this.storage.createJSONItem(this.world);

			this.$("textarea").text(this.json);
			this.$el.modal("show");
		},
		onDownload: function(){
			var blob = new Blob([this.json], { type: "text/plain;charset=utf-8"});
			saveAs(blob, "life.json");
		},
		onSaveToLocalStorage: function(){
			var patternName = this.$("input[type=text]").val();

			this.storage.addJson(this.json, patternName);

			this.$("input[type=text]").val("");
			this.$el.modal("hide");
		}
	});
})()