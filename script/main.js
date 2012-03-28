(function() {
  var Main;
  Main = (function() {
    $(function() {
      $('body').onselectstart = function() {
        return false;
      };
      return window.APP = new Main;
    });
    window.uniqueId = function(length) {
      var id;
      if (length == null) {
        length = 5;
      }
      id = "";
      while (id.length < length) {
        id += Math.random().toString(36).substr(2);
      }
      return id.substr(0, length);
    };
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
      var cage, n, _i, _len, _ref;
      this.welcome_dialog();
      n = 3;
      this.main_grid = new Grid(n);
      cage = new Cage([this.main_grid.get_square("A1"), this.main_grid.get_square("A2")]);
      cage.update_target(5);
      cage.update_operation("+");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("B1"), this.main_grid.get_square("B2")]);
      cage.update_target(2);
      cage.update_operation("/");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("A3"), this.main_grid.get_square("B3")]);
      cage.update_target(2);
      cage.update_operation("-");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("C1")]);
      cage.update_target(1);
      cage.update_operation("+");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("C2"), this.main_grid.get_square("C3")]);
      cage.update_target(6);
      cage.update_operation("*");
      this.main_grid.add_cage(cage);
      console.log("grid - cages");
      console.log(this.main_grid.cages);
      _ref = this.main_grid.cages;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        cage = _ref[_i];
        cage.find_all_candidates(this.main_grid.size);
      }
      /*temp = ["B1","B2"]
      		@main_grid.add_cage(temp)
      		temp = ["A3", "B3"]
      		@main_grid.add_cage(temp)
      		temp = ["C1"]
      		@main_grid.add_cage(temp)
      		temp = ["C2","C3"]
      		@main_grid.add_cage(temp)
      		console.log(@main_grid.cages)
      		*/
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
        return this.modal.show();
      }
    };
    return Main;
  })();
  this.Main = Main;
}).call(this);
