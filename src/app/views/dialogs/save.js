var Application = Application || {};

if (typeof require === "function" && typeof exports === "object" && typeof module === "object"){
	module.exports = Application
	Application = global.Application
}

(function(){
	"use strict";

	Application.SaveDialogView = Backbone.Dialog.extend({
		el: "#saveDialog",
		json: "",
		events: {
			"click #download": "onDownload",
			"click #saveToLocalStorage": "onSaveToLocalStorage"
		},
		render: function(){
			this.json = this.storage.createJSONItem(this.world);

			this.$("textarea").text(this.json);
			this.$el.modal("show");
			return this;
		},
		onDownload: function(){
			var blob = new Blob([this.json], { type: "text/plain;charset=utf-8"});
			saveAs(blob, "life.json");
		},
		onSaveToLocalStorage: function(){
			var patternName = this.$("input[type=text]").val();
			this.storage.addByJson(patternName, this.json);
			this.$("input[type=text]").val("");
			this.$el.modal("hide");
		}
	});
})();