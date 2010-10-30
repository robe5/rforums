/* Flasher */
Flasher = {};
Flasher = {
  autohide_error: null,
  autohide_notice: null,

  error: function(message) {
    var parent = $('#flasherrors');
    this.buildDiv(parent, message);
    this.showDiv(parent);

    if (this.autohide_error != null) {clearTimeout(this.autohide_error);}
    this.autohide_error = setTimeout(Flasher.fadeError, 10000);
  },

  notice: function(message) {
    var parent = $('#flashnotice');
    this.buildDiv(parent, message);
    this.showDiv(parent);

    if (this.autohide_notice != null) {clearTimeout(this.autohide_notice);}
    this.autohide_notice = setTimeout(Flasher.fadeNotice, 10000);
  },
  buildDiv: function(parent, message) {
		parent.html("<div>" + message + "</div>");
  },
  showDiv: function(parent) {
		$(parent).fadeIn(300);
  },
  fadeNotice: function() {
		$('#flashnotice').fadeOut(300); 
    this.autohide_notice = null;
  },

  fadeError: function() {
		$('#flasherrors').fadeOut(300);	 
    this.autohide_error = null;
  }
};