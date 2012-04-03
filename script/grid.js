(function() {
  var Grid;
  Grid = (function() {
    Grid.prototype.size = null;
    Grid.prototype.cages = [];
    Grid.prototype.display = [];
    Grid.prototype.solution = [];
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
    }
    Grid.prototype.add_candidate = function() {};
    Grid.prototype.draw = function() {};
    Grid.prototype.clear = function() {};
    Grid.prototype.update_row = function(row_id, col_id, val) {};
    Grid.prototype.update_column = function(row_id, col_id, val) {};
    Grid.prototype.add_cage = function(cage) {
      return this.cages.push(cage);
    };
    Grid.prototype.remove_cage = function() {};
    Grid.prototype.add_solution = function(solution) {
      return this.solution = solution;
    };
    Grid.prototype.verify_correct = function() {
      var i, valid, _ref;
      valid = true;
      if (solution !== null) {
        for (i = 0, _ref = this.size; 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
          if (display[i].value !== solution[i]) {
            return false;
          }
        }
      } else {
        if (check_rows_are_valid() === false) {
          return false;
        }
        if (check_cols_are_valid() === false) {
          return false;
        }
        if (check_cages_are_valid() === false) {
          return false;
        }
        return valid;
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
            return false;
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
            return false;
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
      var cage, _i, _len, _ref;
      _ref = this.cages;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        cage = _ref[_i];
        if (cage.candidates === null) {
          return false;
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
    Grid.prototype.descending = function(a, b) {
      return b - a;
    };
    Grid.prototype.ascending = function(a, b) {
      return a - b;
    };
    return Grid;
  })();
  this.Grid = Grid;
}).call(this);
