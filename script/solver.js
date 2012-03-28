(function() {
  var Solver;
  Solver = (function() {
    Solver.prototype.current_puzzle = null;
    Solver.prototype.solution_order = [];
    function Solver() {}
    Solver.prototype.solve = function(grid) {
      if (grid.verify_correct() === true) {
        return valid;
      }
      if (cages_have_candidates() === false) {
        return invalid;
      }
      if (backtrack(grid) === invalid) {
        return invalid;
      } else {
        return update;
      }
    };
    Solver.prototype.backtrack = function(grid) {
      profitable_cage;      var potentials;
      return potentials = [];
      /*for candidate in profitable_cage
      			temp = grid
      			temp.
      			potentials.push
      		*/
    };
    Solver.prototype.append_solution_order = function(fresh_vals) {};
    Solver.prototype.update_puzzle_info = function() {};
    return Solver;
  })();
  this.Solver = Solver;
}).call(this);
