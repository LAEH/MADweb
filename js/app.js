app = {
	initialize: function() {
		console.log('app.js:initialize');
		this.showImages();
	},

	showImages: function() {
		$('.img').each(this.rdmVisibility);
		$('.image').each(this.rdmVisibility);
	},

	rdmVisibility: function(idx, el) {
		var $el = $(el);
		var t = Math.round(150 + Math.random() * 600);

		setTimeout(function() {
			$el.addClass('visible');
		}, t);
	},
};