auth = {
	initialize: function() {
		this.$username = $('#username');
		this.$password = $('#password');
		this.$login = $('#login');

		// Include cookies when doing ajax
		$.ajaxSetup({
			xhrFields: {
				withCredentials: true
			},
		});

		this.$login.click($.proxy(this.onClickLogin, this));
	},

	onClickLogin: function(e) {
		e.preventDefault();
		var username = this.$username.val();
		var password = this.$password.val();
		if(!username || !password) return false;

		$.post('https://api.madbits.com/login', {
			username: this.$username.val(),
			password: this.$password.val()
		}, function(resp) {
			if(resp.status) {
				$('#auth').fadeOut(500, function() {
					$(this).remove();
				});
				overview.initialize();
			} else {
				alert('Wrong username/password');
			}
		});
	}

};