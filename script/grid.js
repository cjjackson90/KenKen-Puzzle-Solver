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
      console.log("rows");
      console.log(this.rows);
      console.log("columns");
      console.log(this.columns);
      console.log(this.display);
    }
    Grid.prototype.draw = function() {};
    Grid.prototype.clear = function() {};
    Grid.prototype.update_row = function(row_id, col_id, val) {};
    Grid.prototype.update_column = function(row_id, col_id, val) {};
    Grid.prototype.add_cage = function() {};
    Grid.prototype.remove_cage = function() {};
    return Grid;
  })();
  this.Grid = Grid;
}).call(this);
