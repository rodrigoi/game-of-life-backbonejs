var Application = Application || {};

(function(){
	"use strict";

	Application.Konami = Backbone.View.extend({
		el: "#konami",
		render: function(){
			this.$("iframe").attr("src", "http://www.youtube.com/embed/_acDrLnhOL0?rel=0&autoplay=1");

			this.$el.modal("show");

			var _that = this;
			this.$el.on("hidden", function(){
				_that.$("iframe").attr("src", "");
			});
		}
	});
})();