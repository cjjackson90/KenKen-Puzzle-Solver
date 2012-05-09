(function() {
  var Main;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __indexOf = Array.prototype.indexOf || function(item) {
    for (var i = 0, l = this.length; i < l; i++) {
      if (this[i] === item) return i;
    }
    return -1;
  };
  Main = (function() {
    var add_cage_dialog_open, position_in_display;
    $(function() {
      $('body').onselectstart = function() {
        return false;
      };
      return window.APP = new Main;
    });
    window.uniqueId = function(length) {
      var id;
      if (length == null) {
        length = 3;
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
    add_cage_dialog_open = false;
    position_in_display = 0;
    function Main() {
      this.build_DOM();
      this.main_grid = new Grid(5);
      $('#grid_size').change(__bind(function(e) {
        return this.update_grid_size($('#grid_size').val());
      }, this));
      $('#add_cage').click(__bind(function(e) {
        return this.add_cage_click();
      }, this));
      $('#solve_mode_button').click(__bind(function(e) {
        return this.solve_mode_button_click();
      }, this));
      $('#edit_mode_button').click(__bind(function(e) {
        return this.edit_mode_button_click();
      }, this));
      $('#solve_reset').click(__bind(function(e) {
        return this.solve_reset();
      }, this));
      $('#solve_solution').click(__bind(function(e) {
        return this.solve_solution_button_click();
      }, this));
      $('#solve_step').click(__bind(function(e) {
        return this.solve_next_step();
      }, this));
    }
    Main.prototype.build_DOM = function() {
      $('body').append('<div id="main">\n	<div id="modes">\n		<div id="edit_mode">\n			<div id="edit_top_bar" class="top_bar"></div>\n			<div id="edit_side_bar" class="side_bar" float="left">\n				<img src="img/grid_size.png">\n				<input id="grid_size" type="text" size="1"></input>\n				<p>\n				<p>\n				<div id="add_cage">\n					<div float="left"><img src="img/add_cage2.png"></div>\n				</div>\n			</div>\n		</div>\n		\n		<div id="solve_mode">\n			<div id="solve_top_bar" class="top_bar"></div>\n			<div id="solve_side_bar" class="side_bar" float="left">\n				<div id="solve_reset">\n					<img src="img/reset.png">\n				</div>\n				<div id="solve_step">\n					<img src="img/next_step.png">\n				</div>\n				<div id="solve_solution">\n					<img src="img/solution.png">\n				</div>\n			</div>\n		</div>\n\n		<ul>\n			<li><a id="edit_mode_button" href="#edit_mode">Edit Mode</a></li>\n			<li><a id="solve_mode_button" href="#solve_mode">Solve Mode</a></li>\n		</ul>\n	</div>\n</div>');
      $('#modes').tabs();
      return $(".tabs-bottom .ui-tabs-nav, .tabs-bottom .ui-tabs-nav > * ").removeClass("ui-corner-all ui-corner-top").addClass("ui-corner-bottom");
    };
    Main.prototype.update_grid_size = function(grid_size) {
      console.log(grid_size);
      if (grid_size > 9 || grid_size < 1) {
        alert("Sorry, grid sizes must a value 1-9.");
        return $('#grid_size').val(this.main_grid.size);
      } else {
        $('#grid_lines').remove();
        $('#edit_grid_wrapper > *').remove();
        return this.main_grid = new Grid(grid_size);
      }
    };
    Main.prototype.add_cage_click = function() {
      if (this.add_cage_dialog_open) {
        $('#add_cage_dialog').remove();
        $('.ui-selected').removeClass('ui-selected');
        $('#edit_grid_wrapper').selectable("destroy");
        $('#add_cage').css("visibility", "visible");
        this.add_cage_dialog_open = false;
        return;
      }
      this.add_cage_dialog_open = true;
      $('#edit_grid_wrapper').selectable();
      $('#edit_side_bar').append('<div id="add_cage_dialog" class="instructions">\n	Ctrl+Click squares to add to cage.\n	<p>\n	Target: <input id="target_val" type="text" size="5"></input>\n	<p>\n	Operation: <select id="op_val">\n		<option value="+">+</option>\n		<option value="-">-</option>\n		<option value="*">*</option>\n		<option value="/">/</option>\n	</select>\n	<p>\n	<div position="absolute">\n		<div id="add_cage_ok">Add</div>\n		<p>\n		<div id="add_cage_cancel">Cancel</div>\n	<div>\n</div>');
      $('#add_cage_ok').click(__bind(function(e) {
        var cage, first_sq, i, selected_ids, selected_squares, sq, squares, target, to_check, val, val_letter, val_num, _i, _j, _len, _len2, _ref, _ref2;
        target = $('#target_val').val();
        selected_squares = $('.ui-selected').get();
        selected_ids = [];
        squares = [];
        for (_i = 0, _len = selected_squares.length; _i < _len; _i++) {
          sq = selected_squares[_i];
          selected_ids.push($(sq).attr('id'));
          squares.push(this.main_grid.get_square($(sq).attr('id')));
        }
        cage = new Cage(squares);
        cage.update_target(parseInt(target));
        cage.update_operation($('#op_val').val());
        cage.update_square_cage_ids();
        cage.location[0].set_target_op(cage.target, cage.operation);
        this.main_grid.add_cage(cage);
        first_sq = true;
        _ref = cage.location;
        for (_j = 0, _len2 = _ref.length; _j < _len2; _j++) {
          val = _ref[_j];
          val_letter = val.row_id;
          val_num = val.column_id + 1;
          if (first_sq) {
            $('#' + val.id + ' > div').append(val.target_op);
            first_sq = false;
          }
          to_check = [];
          to_check.push(String.fromCharCode(val_letter + 64) + val_num);
          to_check.push(String.fromCharCode(val_letter + 66) + val_num);
          to_check.push(String.fromCharCode(val_letter + 65) + (val_num + 1));
          to_check.push(String.fromCharCode(val_letter + 65) + (val_num - 1));
          $('#' + val.id).css({
            "border": "8px solid #7FD13B"
          });
          for (i = 0; i < 4; i++) {
            if ((_ref2 = to_check[i], __indexOf.call(selected_ids, _ref2) >= 0)) {
              switch (i) {
                case 0:
                  $('#' + val.id).css({
                    "border-top": "1px solid #D6ECFF"
                  });
                  break;
                case 1:
                  $('#' + val.id).css({
                    "border-bottom": "1px solid #D6ECFF"
                  });
                  break;
                case 2:
                  $('#' + val.id).css({
                    "border-right": "1px solid #D6ECFF"
                  });
                  break;
                case 3:
                  $('#' + val.id).css({
                    "border-left": "1px solid #D6ECFF"
                  });
              }
            }
          }
        }
        $('.ui-selected').removeClass("ui-selected");
        return $('#add_cage').css("visibility", "visible");
      }, this));
      return $('#add_cage_cancel').click(__bind(function(e) {
        $('#add_cage_dialog').remove();
        $('.ui-selected').removeClass('ui-selected');
        $('#edit_grid_wrapper').selectable("destroy");
        return $('#add_cage').css("visibility", "visible");
      }, this));
    };
    Main.prototype.solve_mode_button_click = function() {
      var cage, current_grid, end, solver, start, time, _i, _len, _ref, _return;
      $('#solve_mode').append('<div id="solve_grid_wrapper">\n</div>');
      $('#edit_grid_wrapper').children().clone().appendTo('#solve_grid_wrapper');
      _ref = this.main_grid.cages;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        cage = _ref[_i];
        cage.find_all_candidates(parseInt(this.main_grid.size));
      }
      start = new Date().getTime();
      solver = new Solver(this.main_grid);
      current_grid = this.main_grid;
      _return = solver.solve(current_grid, 0);
      switch (_return.status) {
        case "valid":
          console.log("WOO! Solution! :D");
          current_grid = _return.valid_grid;
          break;
        case "invalid":
          if ((_return.reason != null)) {
            console.log("Solvr timed out!");
          }
          console.log("Boo! No solution :(");
          break;
        case "debug":
          console.log("Debugging...");
          current_grid = _return.grid;
          break;
      }
      end = new Date().getTime();
      time = end - start;
      console.log(time);
      this.main_grid = current_grid;
      this.main_grid.add_solution(this.main_grid.display);
      return this.main_grid.add_solution_order(solver.solution_order);
    };
    Main.prototype.edit_mode_button_click = function() {
      return $('#solve_grid_wrapper').remove();
    };
    Main.prototype.solve_solution_button_click = function() {
      var id, sq, _i, _len, _ref, _results;
      _ref = this.main_grid.solution;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        sq = _ref[_i];
        id = sq.id;
        _results.push($('#solve_grid_wrapper > #' + id).append(sq.value));
      }
      return _results;
    };
    Main.prototype.solve_reset = function() {
      position_in_display = 0;
      $('#solve_grid_wrapper').empty();
      return $('#edit_grid_wrapper').children().clone().appendTo('#solve_grid_wrapper');
    };
    Main.prototype.solve_next_step = function() {
      var sq, _i, _len, _ref;
      _ref = this.main_grid.solution_order[position_in_display];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        sq = _ref[_i];
        $('#solve_grid_wrapper > #' + sq.id).append(sq.value);
      }
      return position_in_display++;
    };
    return Main;
  })();
  this.Main = Main;
}).call(this);
