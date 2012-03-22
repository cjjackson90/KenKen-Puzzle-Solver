(function() {
  var Main;
  Main = (function() {
    $(function() {
      $('body').onselectstart = function() {
        return false;
      };
      return window.APP = new Main;
    });
    window.setCookie = function(name, value, days) {
      var date, expires;
      if (days) {
        date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + (date.toGMTString());
      } else {
        expires = "";
      }
      return document.cookie = "" + name + "=" + value + expires + "; path=/";
    };
    window.getCookie = function(name) {
      var c, ca, nameEQ, _i, _len;
      nameEQ = "" + name + "=";
      ca = document.cookie.split(';');
      for (_i = 0, _len = ca.length; _i < _len; _i++) {
        c = ca[_i];
        while (' ' === c.charAt(0)) {
          c = c.substring(1, c.length);
        }
        if (0 === c.indexOf(nameEQ)) {
          return c.substring(nameEQ.length, c.length);
        }
      }
      return null;
    };
    window.deleteCookie = function(name) {
      return setCookie(name, "", -1);
    };
    function Main() {
      var n;
      this.welcome_dialog();
      n = 5;
      this.main_grid = new Grid(n);
    }
    Main.prototype.welcome_dialog = function() {
      if ("false" !== getCookie("welcome")) {
        this.modal = new Modal({
          title: "Welcome to Solvr!",
          intro: "<p>\n	Welcome screen text. Lorem ipsum. Lorem ipsum. Lorem ipsum. Lorem ipsum.\n	Lorem ipsum. Lorem ipsum. Lorem ipsum. Lorem ipsum. Lorem ipsum.\n	Lorem ipsum. Lorem ipsum. Lorem ipsum. Lorem ipsum. Lorem ipsum.\n	Insert an img below\n</p>\n<img src=\"img/welcome1.png\" alt=\"Toolbar Diagram\" />\n<p>\n	Some extra explanation text. Yeah, boi! Maybe take user input...\n</p>",
          okay: "Don't show this again!",
          cancel: "Okay, thanks!",
          callback: function(r) {
            return setCookie("welcome", "false");
          }
        });
        this.modal.div.css({
          width: 600,
          "margin-left": 300
        });
        return this.modal.show();
      }
    };
    return Main;
  })();
  this.Main = Main;
}).call(this);
