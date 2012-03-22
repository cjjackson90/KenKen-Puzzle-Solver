(function() {
  var Solver;
  Solver = (function() {
    Solver.prototype.current_puzzle = null;
    Solver.prototype.solution_order = [];
    function Solver() {}
    Solver.prototype.solve = function(grid) {};
    Solver.prototype.backtrack = function(grid) {};
    Solver.prototype.append_solution_order = function(fresh_vals) {};
    Solver.prototype.update_puzzle_info = function() {};
    return Solver;
  })();
  this.Solver = Solver;
}).call(this);
