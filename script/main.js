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
      var cage, n, _i, _j, _len, _len2, _ref, _ref2;
      this.welcome_dialog();
      /*
      		n = 3
      		@main_grid = new Grid(n)
      
      		cage = new Cage([@main_grid.get_square("A1"), @main_grid.get_square("A2")])
      		cage.update_target(5)
      		cage.update_operation("+")
      		@main_grid.add_cage(cage)
      		#console.log(@main_grid.cages)
      
      		cage = new Cage([@main_grid.get_square("B1"), @main_grid.get_square("B2")])
      		cage.update_target(2)
      		cage.update_operation("/")
      		@main_grid.add_cage(cage)
      		#console.log(@main_grid.cages)
      
      		cage = new Cage([@main_grid.get_square("A3"), @main_grid.get_square("B3")])
      		cage.update_target(2)
      		cage.update_operation("-")
      		@main_grid.add_cage(cage)
      		#console.log(@main_grid.cages)
      
      		cage = new Cage([@main_grid.get_square("C1")])
      		cage.update_target(1)
      		cage.update_operation("+")
      		@main_grid.add_cage(cage)
      		#console.log(@main_grid.cages)
      
      		cage = new Cage([@main_grid.get_square("C2"), @main_grid.get_square("C3")])
      		cage.update_target(6)
      		cage.update_operation("*")
      		@main_grid.add_cage(cage)
      
      		console.log("grid - cages")
      		console.log(@main_grid.cages)
      		*/
      /*
      		n = 5
      		@main_grid = new Grid(n)
      
      		cage = new Cage([@main_grid.get_square("A1"), @main_grid.get_square("A2"), @main_grid.get_square("B1"), @main_grid.get_square("C1"), @main_grid.get_square("C2")])
      		cage.update_target(12)
      		cage.update_operation("*")
      		@main_grid.add_cage(cage)
      
      		cage = new Cage([@main_grid.get_square("A3"), @main_grid.get_square("A4"), @main_grid.get_square("B2"), @main_grid.get_square("B3"), @main_grid.get_square("B4")])
      		cage.update_target(21)
      		cage.update_operation("+")
      		@main_grid.add_cage(cage)
      
      		cage = new Cage([@main_grid.get_square("A5"), @main_grid.get_square("B5"), @main_grid.get_square("C5")])
      		cage.update_target(24)
      		cage.update_operation("*")
      		@main_grid.add_cage(cage)
      
      		cage = new Cage([@main_grid.get_square("C3"), @main_grid.get_square("C4")])
      		cage.update_target(4)
      		cage.update_operation("-")
      		@main_grid.add_cage(cage)
      
      		cage = new Cage([@main_grid.get_square("D1"), @main_grid.get_square("D2"), @main_grid.get_square("E1"), @main_grid.get_square("E2")])
      		cage.update_target(16)
      		cage.update_operation("+")
      		@main_grid.add_cage(cage)
      
      		cage = new Cage([@main_grid.get_square("D3"), @main_grid.get_square("E3"), @main_grid.get_square("E4"), @main_grid.get_square("E5")])
      		cage.update_target(6)
      		cage.update_operation("*")
      		@main_grid.add_cage(cage)
      
      		cage = new Cage([@main_grid.get_square("D4"), @main_grid.get_square("D5")])
      		cage.update_target(3)
      		cage.update_operation("-")
      		@main_grid.add_cage(cage)
      
      		console.log("grid - cages")
      		console.log(@main_grid.cages)
      		*/
      n = 6;
      this.main_grid = new Grid(n);
      cage = new Cage([this.main_grid.get_square("A1"), this.main_grid.get_square("A2"), this.main_grid.get_square("A3"), this.main_grid.get_square("B1")]);
      cage.update_target(90);
      cage.update_operation("*");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("A4"), this.main_grid.get_square("A5"), this.main_grid.get_square("A6"), this.main_grid.get_square("B6")]);
      cage.update_target(13);
      cage.update_operation("+");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("B2"), this.main_grid.get_square("C1"), this.main_grid.get_square("C2")]);
      cage.update_target(11);
      cage.update_operation("+");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("B3"), this.main_grid.get_square("B4")]);
      cage.update_target(4);
      cage.update_operation("-");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("B5"), this.main_grid.get_square("C5"), this.main_grid.get_square("C6")]);
      cage.update_target(60);
      cage.update_operation("*");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("C3"), this.main_grid.get_square("C4"), this.main_grid.get_square("D4"), this.main_grid.get_square("D5")]);
      cage.update_target(180);
      cage.update_operation("*");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("D1"), this.main_grid.get_square("E1")]);
      cage.update_target(2);
      cage.update_operation("/");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("D2"), this.main_grid.get_square("E2")]);
      cage.update_target(1);
      cage.update_operation("-");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("D5"), this.main_grid.get_square("E5")]);
      cage.update_target(6);
      cage.update_operation("*");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("D6"), this.main_grid.get_square("E6")]);
      cage.update_target(5);
      cage.update_operation("-");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("E3"), this.main_grid.get_square("F1"), this.main_grid.get_square("F2"), this.main_grid.get_square("F3")]);
      cage.update_target(432);
      cage.update_operation("*");
      this.main_grid.add_cage(cage);
      cage = new Cage([this.main_grid.get_square("E4"), this.main_grid.get_square("F4"), this.main_grid.get_square("F5"), this.main_grid.get_square("F6")]);
      cage.update_target(12);
      cage.update_operation("+");
      this.main_grid.add_cage(cage);
      _ref = this.main_grid.cages;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        cage = _ref[_i];
        cage.find_all_candidates(this.main_grid.size);
      }
      _ref2 = this.main_grid.cages;
      for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
        cage = _ref2[_j];
        cage.remove_duplicates();
      }
      console.log(this.main_grid.cages);
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
