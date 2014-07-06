overview = {
	initialize: function() {
		this.$sidebar = $('#sidebar');
		this.$container = $('#container');

		$.getJSON( "/uploaded.json", $.proxy(this.render, this));
	},

	render: function(table) {
		console.log('overview.js:table', table);
		for(var i = 0; i < Object.keys(table).length; i++) {

			var key = Object.keys(table)[i];
			var path = [key];

			if(typeof table[key] !== 'object') {
				this.renderHeader(null, path);
				this.renderContent(key, path);
				continue;
			} else {
				this.renderHeader(key, path);
				this.recFunc(table[key], path);
			}
		}
	},

	recFunc: function(node, path) {
		var key, path_copy;

		if(this.isLeaf(node)) {
			key = Object.keys(node)[];
			path.push(key);
			this.renderHeader(null, path);
			this.renderContent(key, path);
		} else {
			var keys = Object.keys(node);

			for(var i = 0; i < keys.length; i++) {

				key = keys[i];
				path_copy = path.slice();

				if(typeof node[key] !== 'object') {
					path_copy.push(key);
					this.renderHeader(null, path_copy);
					this.renderContent(key, path_copy);
				} else {
					path_copy.push(key);
					this.renderHeader(key, path_copy);
					this.recFunc(node[key], path_copy);
				}
			}
		}
	},

	isLeaf: function(node) {
		return typeof node === 'object' && Object.keys(node).length === 1 && typeof node[Object.keys(node).length -1] === 'boolean';
	},

	renderHeader: function(title, path) {
		var $toc = $('<li>');

		if(!title) {
			$toc.append($('<a>', { 'href': '#' + path.join('_'), 'html': path[path.length - 1] }));
			$toc.addClass('last');
		} else {
			$toc.html(title);
		}

		$toc.addClass('level_' + (path.length - 1));
		this.$sidebar.append($toc);
	},

	renderContent: function(title, path) {
		var data = {
			_id: path.join('_'),
			filename: path.join('_'),
			title: path.join(' > ')
		};

		var $content = $('<div>', { 'class': 'label', 'id': data._id });
		var $title = $('<h1>', { html: data.title });
		var $img = $('<img>', { 'src': '/uploaded/' + data.filename + '.jpg' });

		$content.append($title);
		$content.append($img);
		this.$container.append($content);
	},
};
