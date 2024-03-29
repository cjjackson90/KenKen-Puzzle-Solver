(function() {
  var Grid;
  Grid = (function() {
    Grid.prototype.size = null;
    Grid.prototype.cages = [];
    Grid.prototype.display = [];
    Grid.prototype.solution = [];
    Grid.prototype.solution_order = [];
    Grid.prototype.rows = [];
    Grid.prototype.columns = [];
    function Grid(grid_size) {
      var i, j, _ref, _ref2;
      this.size = grid_size;
      for (i = 0, _ref = this.size; 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
        this.rows[i] = [];
        this.columns[i] = [];
        this.display[i] = [];
        for (j = 0, _ref2 = this.size; 0 <= _ref2 ? j < _ref2 : j > _ref2; 0 <= _ref2 ? j++ : j--) {
          this.rows[i][j] = j + 1;
          this.columns[i][j] = j + 1;
          this.display[i][j] = new Square(i, j);
        }
      }
      $('#edit_grid_wrapper').remove();
      this.draw();
    }
    Grid.prototype.draw = function() {
      var i, j, letter, num, sq_size, _ref, _ref2;
      $('#edit_mode').append('<div id="edit_grid_wrapper">\n</div>');
      for (i = 0, _ref = this.size; 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
        letter = String.fromCharCode(65 + (i % this.size));
        for (j = 0, _ref2 = this.size; 0 <= _ref2 ? j < _ref2 : j > _ref2; 0 <= _ref2 ? j++ : j--) {
          num = j + 1;
          $('#edit_grid_wrapper').append('<div id="' + letter + '' + num + '"><div class="op_target">&nbsp;</div>&nbsp;</div>');
        }
      }
      sq_size = $('#edit_grid_wrapper').height() / this.size;
      return $('#edit_grid_wrapper > div, #grid_lines > div').css({
        "width": "" + sq_size + "px",
        "height": "" + sq_size + "px"
      });
    };
    Grid.prototype.clear = function() {
      return {
        size: null,
        cages: [],
        display: [],
        solution: [],
        rows: [],
        columns: []
      };
    };
    Grid.prototype.update_row = function(row_id, val) {
      return this.rows[row_id][val - 1] = null;
    };
    Grid.prototype.update_column = function(col_id, val) {
      return this.columns[col_id][val - 1] = null;
    };
    Grid.prototype.add_cage = function(cage) {
      return this.cages.push(cage);
    };
    Grid.prototype.add_solution = function(solution) {
      var i, j, _ref, _results;
      _results = [];
      for (i = 0, _ref = this.size; 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
        _results.push((function() {
          var _ref2, _results2;
          _results2 = [];
          for (j = 0, _ref2 = this.size; 0 <= _ref2 ? j < _ref2 : j > _ref2; 0 <= _ref2 ? j++ : j--) {
            _results2.push(this.solution.push(this.display[i][j]));
          }
          return _results2;
        }).call(this));
      }
      return _results;
    };
    Grid.prototype.add_solution_order = function(solution_order) {
      return this.solution_order = solution_order;
    };
    Grid.prototype.verify_correct = function() {
      var col_check, i, row_check, _ref, _results;
      if (this.solution.length === []) {
        _results = [];
        for (i = 0, _ref = this.size; 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
          if (this.display[i].value != null) {
            if (this.display[i].value !== this.solution[i]) {
              return false;
            }
          } else {
            return false;
          }
        }
        return _results;
      } else {
        row_check = this.check_rows_are_valid();
        if (row_check.status === "inconsistent") {
          return row_check;
        }
        col_check = this.check_cols_are_valid();
        if (col_check.status === "inconsistent") {
          return col_check;
        }
        if (this.check_cages_are_valid() === false) {
          if (row_check.status === "consistent" && col_check.status === "consistent") {
            return {
              status: "consistent"
            };
          } else {
            return {
              status: "inconsistent"
            };
          }
        } else {
          return {
            status: "valid"
          };
        }
      }
    };
    Grid.prototype.check_rows_are_valid = function() {
      var cmp, current_row, element, i, row, sorted, valid, _i, _ref, _ref2, _ref3, _ref4, _results;
      cmp = (function() {
        _results = [];
        for (var _i = 1, _ref = this.size; 1 <= _ref ? _i <= _ref : _i >= _ref; 1 <= _ref ? _i++ : _i--){ _results.push(_i); }
        return _results;
      }).apply(this, arguments);
      valid = true;
      for (row = 0, _ref2 = this.size; 0 <= _ref2 ? row < _ref2 : row > _ref2; 0 <= _ref2 ? row++ : row--) {
        current_row = [];
        for (element = 0, _ref3 = this.size; 0 <= _ref3 ? element < _ref3 : element > _ref3; 0 <= _ref3 ? element++ : element--) {
          current_row.push(this.display[row][element].value);
        }
        sorted = current_row.sort(this.ascending);
        for (i = 0, _ref4 = sorted.length; 0 <= _ref4 ? i < _ref4 : i > _ref4; 0 <= _ref4 ? i++ : i--) {
          if (sorted[i] !== cmp[i]) {
            if (sorted[i] === null) {
              return {
                status: "consistent"
              };
            } else {
              return {
                status: "inconsistent"
              };
            }
          }
        }
      }
      return valid;
    };
    Grid.prototype.check_cols_are_valid = function() {
      var cmp, col, current_col, element, i, sorted, valid, _i, _ref, _ref2, _ref3, _ref4, _results;
      cmp = (function() {
        _results = [];
        for (var _i = 1, _ref = this.size; 1 <= _ref ? _i <= _ref : _i >= _ref; 1 <= _ref ? _i++ : _i--){ _results.push(_i); }
        return _results;
      }).apply(this, arguments);
      valid = true;
      for (col = 0, _ref2 = this.size; 0 <= _ref2 ? col < _ref2 : col > _ref2; 0 <= _ref2 ? col++ : col--) {
        current_col = [];
        for (element = 0, _ref3 = this.size; 0 <= _ref3 ? element < _ref3 : element > _ref3; 0 <= _ref3 ? element++ : element--) {
          current_col.push(this.display[element][col].value);
        }
        sorted = current_col.sort(this.ascending);
        for (i = 0, _ref4 = sorted.length; 0 <= _ref4 ? i < _ref4 : i > _ref4; 0 <= _ref4 ? i++ : i--) {
          if (sorted[i] !== cmp[i]) {
            if (sorted[i] === null) {
              return {
                status: "consistent"
              };
            } else {
              return {
                status: "inconsistent"
              };
            }
          }
        }
      }
      return valid;
    };
    Grid.prototype.check_cages_are_valid = function() {
      var cage, cage_nums, cage_value, i, sorted, _i, _j, _k, _l, _len, _len2, _len3, _len4, _len5, _len6, _m, _n, _ref, _ref2, _ref3, _ref4;
      _ref = this.cages;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        cage = _ref[_i];
        cage_nums = [];
        _ref2 = cage.location;
        for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
          i = _ref2[_j];
          cage_nums.push(i.value);
        }
        switch (cage.operation) {
          case "+":
            cage_value = 0;
            for (_k = 0, _len3 = cage_nums.length; _k < _len3; _k++) {
              i = cage_nums[_k];
              cage_value += i;
            }
            if (cage_value !== cage.target) {
              return false;
            }
            break;
          case "-":
            sorted = cage_nums.sort(this.descending);
            cage_value = sorted[0];
            _ref3 = sorted.slice(1, sorted.size);
            for (_l = 0, _len4 = _ref3.length; _l < _len4; _l++) {
              i = _ref3[_l];
              cage_value -= i;
            }
            if (cage_value !== cage.target) {
              return false;
            }
            break;
          case "*":
            cage_value = 1;
            for (_m = 0, _len5 = cage_nums.length; _m < _len5; _m++) {
              i = cage_nums[_m];
              cage_value *= i;
            }
            if (cage_value !== cage.target) {
              return false;
            }
            break;
          case "/":
            sorted = cage_nums.sort(this.descending);
            cage_value = sorted[0];
            _ref4 = sorted.slice(1, sorted.size);
            for (_n = 0, _len6 = _ref4.length; _n < _len6; _n++) {
              i = _ref4[_n];
              cage_value /= i;
            }
            if (cage_value !== cage.target) {
              return false;
            }
        }
      }
      return true;
    };
    Grid.prototype.cages_have_candidates = function() {
      var cage, sq, _i, _j, _len, _len2, _ref, _ref2;
      _ref = this.cages;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        cage = _ref[_i];
        if (cage.candidates === null) {
          _ref2 = cage.location;
          for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
            sq = _ref2[_j];
            if (!(sq.value != null)) {
              return false;
            }
          }
        }
      }
      return true;
    };
    Grid.prototype.get_square = function(square_id) {
      var column, row;
      row = square_id.substring(0, 1).charCodeAt(0) - 65;
      column = square_id.substring(1) - 1;
      return this.display[row][column];
    };
    Grid.prototype.ascending = function(a, b) {
      return a - b;
    };
    Grid.prototype.descending = function(a, b) {
      return b - a;
    };
    Grid.prototype.remove = function(arr, val) {
      var x, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = arr.length; _i < _len; _i++) {
        x = arr[_i];
        if (x !== val) {
          _results.push(x);
        }
      }
      return _results;
    };
    Grid.prototype.remove_array = function(arr, val) {
      var current, i, mismatch, output, _i, _len, _ref;
      output = [];
      for (_i = 0, _len = arr.length; _i < _len; _i++) {
        current = arr[_i];
        mismatch = false;
        for (i = 0, _ref = current.length; 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
          if (current[i] !== val[i]) {
            mismatch = true;
            break;
          }
        }
        if (mismatch === true) {
          output.push(current);
        }
      }
      return output;
    };
    return Grid;
  })();
  this.Grid = Grid;
}).call(this);
