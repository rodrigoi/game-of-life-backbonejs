var Application = Application || {};

if (typeof module !== "undefined" && module.exports) {
	var Backbone = Backbone || require("backbone");

	module.exports = Application;
}

(function(){
	"use strict";

	Application.SaveDialogView = Backbone.View.extend({
		el: "#saveDialog",
		jsonCollection: null,
		events: {
			"click #download": "onDownload",
			"click #saveToLocalStorage": "onSaveToLocalStorage"
		},
		render: function(){
			if(this.collection){
				this.jsonCollection = JSON.stringify({
					world: this.collection,
					width: this.collection.width,
					height: this.collection.height,
					type: "world"
				});

				this.$("textarea").text(this.jsonCollection);
				this.$el.modal("show");
			}
		},
		onDownload: function(){
			var blob = new Blob([this.jsonCollection], { type: "text/plain;charset=utf-8"});
			saveAs(blob, "life.json");
		},
		onSaveToLocalStorage: function(){
			var patternName = this.$("input[type=text]").val();
			//name validation please!
			localStorage.setItem(patternName, this.jsonCollection);
			this.$("input[type=text]").val("");
			this.$el.modal("hide");
		}
	});
})()