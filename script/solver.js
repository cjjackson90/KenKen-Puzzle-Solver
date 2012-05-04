(function() {
  var Solver;
  Solver = (function() {
    Solver.prototype.current_puzzle = null;
    Solver.prototype.solution_order = [];
    Solver.prototype.strat = null;
    function Solver() {
      this.strat = new Strategies();
    }
    Solver.prototype.solve = function(grid, depth) {
      var grid_complete, i, j, new_grid, obj, potentials, return_obj, sq, temp, test, test2, verified_correct, _i, _j, _k, _len, _len2, _len3, _ref, _ref2, _ref3, _ref4;
      grid_complete = true;
      for (i = 0, _ref = grid.size; 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
        for (j = 0, _ref2 = grid.size; 0 <= _ref2 ? j < _ref2 : j > _ref2; 0 <= _ref2 ? j++ : j--) {
          if (grid.display[i][j].value === null) {
            grid_complete = false;
            break;
          }
        }
      }
      verified_correct = grid.verify_correct();
      if (verified_correct.status === "valid") {
        return_obj = {
          status: "valid",
          valid_grid: grid
        };
        return return_obj;
      }
      if (verified_correct.status === "inconsistent") {
        return_obj = {
          status: "invalid"
        };
        return return_obj;
      }
      if (grid.cages_have_candidates() === false) {
        return_obj = {
          status: "invalid"
        };
        return return_obj;
      }
      test = this.strat.one_candidate(grid);
      if (test.status === true) {
        console.log("strat1 = success!");
        _ref3 = test.vals;
        for (_i = 0, _len = _ref3.length; _i < _len; _i++) {
          sq = _ref3[_i];
          temp = this.update_puzzle_info(grid, sq.row_id, sq.column_id, sq.cage_id, sq.value);
          grid = temp;
        }
        return_obj = this.solve(grid, depth + 1);
        switch (return_obj.status) {
          case "valid":
            return return_obj;
          case "invalid":
            return {
              status: "invalid"
            };
        }
      }
      test2 = this.strat.common_numbers(grid);
      if (test2.status === true) {
        console.log("strat2 = success!");
        _ref4 = test2.vals;
        for (_j = 0, _len2 = _ref4.length; _j < _len2; _j++) {
          obj = _ref4[_j];
          console.log("obj.cage_id = " + obj.cage_id);
          if (obj.row_or_col === "row") {
            grid = this.update_puzzle_info(grid, obj.id, -1, obj.cage_id, obj.val);
          } else {
            grid = this.update_puzzle_info(grid, -1, obj.id, obj.cage_id, obj.val);
          }
        }
        if (depth > 5) {
          return_obj = {
            status: "debug",
            grid: test2.grid
          };
          return return_obj;
        }
        return_obj = this.solve(grid, depth + 1);
        switch (return_obj.status) {
          case "valid":
            return return_obj;
          case "invalid":
            return {
              status: "invalid"
            };
        }
      }
      potentials = this.get_potentials(grid);
      for (_k = 0, _len3 = potentials.length; _k < _len3; _k++) {
        new_grid = potentials[_k];
        return_obj = this.solve(new_grid, depth + 1);
        switch (return_obj.status) {
          case "update":
            return return_obj;
          case "valid":
            return return_obj;
        }
      }
      return {
        status: "invalid"
      };
    };
    Solver.prototype.get_potentials = function(grid) {
      var cage, candidate, first_index, i, potentials, profitable_cage, smallest_cage, smallest_length, sq, square, temp, viable, viable_cage, _i, _j, _k, _l, _len, _len2, _len3, _len4, _len5, _m, _ref, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7;
      profitable_cage = null;
      potentials = [];
      smallest_cage = grid.cages[0];
      first_index = 0;
      for (i = 0, _ref = grid.cages.length; 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
        viable_cage = false;
        _ref2 = grid.cages[i].location;
        for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
          sq = _ref2[_i];
          if (sq.value === null) {
            viable_cage = true;
            break;
          }
        }
        if (viable_cage === true) {
          smallest_cage = grid.cages[i];
          first_index = i;
          break;
        }
      }
      smallest_length = smallest_cage.candidates.length;
      _ref3 = grid.cages.slice(first_index + 1, grid.cages.length);
      for (_j = 0, _len2 = _ref3.length; _j < _len2; _j++) {
        cage = _ref3[_j];
        viable = false;
        if (cage.candidates.length !== 0) {
          _ref4 = cage.location;
          for (_k = 0, _len3 = _ref4.length; _k < _len3; _k++) {
            square = _ref4[_k];
            if (square.value === null) {
              viable = true;
              break;
            }
          }
        }
        if (cage.candidates.length < smallest_length && viable) {
          smallest_cage = cage;
          smallest_length = cage.candidates.length;
        }
      }
      profitable_cage = smallest_cage;
      _ref5 = profitable_cage.candidates;
      for (_l = 0, _len4 = _ref5.length; _l < _len4; _l++) {
        candidate = _ref5[_l];
        temp = this.clone(grid);
        _ref6 = temp.cages;
        for (_m = 0, _len5 = _ref6.length; _m < _len5; _m++) {
          cage = _ref6[_m];
          for (i = 0, _ref7 = cage.location.length; 0 <= _ref7 ? i < _ref7 : i > _ref7; 0 <= _ref7 ? i++ : i--) {
            cage.location[i] = temp.get_square(cage.location[i].id);
          }
          if (cage.id === profitable_cage.id) {
            temp.add_candidate(cage.location, candidate);
          }
        }
        potentials.push(this.clone(temp));
      }
      potentials;
      return potentials;
    };
    Solver.prototype.append_solution_order = function(fresh_vals) {};
    Solver.prototype.update_puzzle_info = function(grid, row_id, col_id, cage_id, fresh_val) {
      var cage, cand_index, candidate, i, j, rem_info, selective_reduction, sq, to_remove, _i, _j, _k, _l, _len, _len2, _len3, _len4, _len5, _m, _ref, _ref2, _ref3, _ref4, _ref5, _ref6;
      selective_reduction = false;
      if (row_id === -1 || col_id === -1) {
        selective_reduction = true;
      }
      if (row_id !== -1) {
        grid.update_row(row_id, fresh_val);
        _ref = grid.display[row_id];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          sq = _ref[_i];
          cage = ((function() {
            var _j, _len2, _ref2, _results;
            _ref2 = grid.cages;
            _results = [];
            for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
              cage = _ref2[_j];
              if (cage.id === sq.cage_id) {
                _results.push(cage);
              }
            }
            return _results;
          })())[0];
          if (cage != null) {
            if (selective_reduction) {
              if (cage.id === cage_id) {
                continue;
              }
            }
            cand_index = 0;
            for (i = 0, _ref2 = cage.location.length; 0 <= _ref2 ? i < _ref2 : i > _ref2; 0 <= _ref2 ? i++ : i--) {
              if (cage.location[i] === sq) {
                cand_index = i;
              }
            }
            to_remove = [];
            _ref3 = cage.candidates;
            for (_j = 0, _len2 = _ref3.length; _j < _len2; _j++) {
              candidate = _ref3[_j];
              if (candidate[cand_index] === fresh_val) {
                to_remove.push(candidate);
              }
            }
            for (_k = 0, _len3 = to_remove.length; _k < _len3; _k++) {
              rem_info = to_remove[_k];
              cage.candidates = this.remove(cage.candidates, rem_info);
            }
          }
        }
      }
      if (col_id !== -1) {
        grid.update_column(col_id, fresh_val);
        for (i = 0, _ref4 = grid.size; 0 <= _ref4 ? i < _ref4 : i > _ref4; 0 <= _ref4 ? i++ : i--) {
          sq = grid.display[i][col_id];
          cage = ((function() {
            var _l, _len4, _ref5, _results;
            _ref5 = grid.cages;
            _results = [];
            for (_l = 0, _len4 = _ref5.length; _l < _len4; _l++) {
              cage = _ref5[_l];
              if (cage.id === sq.cage_id) {
                _results.push(cage);
              }
            }
            return _results;
          })())[0];
          if (cage != null) {
            if (selective_reduction) {
              if (cage.id === cage_id) {
                continue;
              }
            }
            cand_index = 0;
            for (j = 0, _ref5 = cage.location.length; 0 <= _ref5 ? j < _ref5 : j > _ref5; 0 <= _ref5 ? j++ : j--) {
              if (cage.location[j] === sq) {
                cand_index = j;
              }
            }
            to_remove = [];
            _ref6 = cage.candidates;
            for (_l = 0, _len4 = _ref6.length; _l < _len4; _l++) {
              candidate = _ref6[_l];
              if (candidate[cand_index] === fresh_val) {
                to_remove.push(candidate);
              }
            }
            for (_m = 0, _len5 = to_remove.length; _m < _len5; _m++) {
              rem_info = to_remove[_m];
              cage.candidates = this.remove(cage.candidates, rem_info);
            }
          }
        }
      }
      return grid;
    };
    Solver.prototype.clone = function(obj) {
      var key, newInstance;
      if (!(obj != null) || typeof obj !== 'object') {
        return obj;
      }
      newInstance = new obj.constructor();
      for (key in obj) {
        newInstance[key] = this.clone(obj[key]);
      }
      return newInstance;
    };
    Solver.prototype.remove = function(arr, val) {
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
    return Solver;
  })();
  this.Solver = Solver;
}).call(this);
