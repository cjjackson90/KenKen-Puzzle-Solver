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
    Grid.prototype.cages_have_candidates = function() {
      var cage, _i, _len;
      for (_i = 0, _len = cages.length; _i < _len; _i++) {
        cage = cages[_i];
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
    return Grid;
  })();
  this.Grid = Grid;
}).call(this);
