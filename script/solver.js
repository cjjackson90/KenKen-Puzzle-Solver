(function() {
  var Solver;
  Solver = (function() {
    Solver.prototype.current_puzzle = null;
    Solver.prototype.solution_order = [];
    function Solver() {}
    Solver.prototype.solve = function(grid) {
      var cage, grid_complete, i, j, new_grid, potentials, return_obj, verified_correct, _i, _j, _len, _len2, _ref, _ref2, _ref3, _ref4;
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
      if (verified_correct === false && grid_complete === true) {
        return_obj = {
          status: "invalid"
        };
        return return_obj;
      }
      if (verified_correct === true) {
        return_obj = {
          status: "valid",
          valid_grid: grid
        };
        return return_obj;
      }
      if (grid.cages_have_candidates() === false) {
        return_obj = {
          status: "invalid"
        };
        return return_obj;
      }
      potentials = this.get_potentials(grid);
      console.log("potentials");
      console.log(potentials);
      for (i = 0, _ref3 = potentials.length; 0 <= _ref3 ? i < _ref3 : i > _ref3; 0 <= _ref3 ? i++ : i--) {
        _ref4 = potentials[i].cages;
        for (_i = 0, _len = _ref4.length; _i < _len; _i++) {
          cage = _ref4[_i];
          if ((cage.location[0] != null) && (cage.location[1] != null) && (cage.location[2] != null)) {
            console.log("A2 = " + cage.location[0].value + ", B2 = " + cage.location[1].value + ", B3 = " + cage.location[2].value);
            if (cage.location[0].value === 2 && cage.location[1].value === 3 && cage.location[2].value === 2) {
              console.log("************232 exists!");
            }
          }
        }
      }
      if (potentials.length === 1) {
        return_obj = {
          status: "update",
          updated_grid: potentials[0]
        };
        return return_obj;
      }
      console.log("potentials 2");
      console.log(potentials);
      for (_j = 0, _len2 = potentials.length; _j < _len2; _j++) {
        new_grid = potentials[_j];
        return_obj = this.solve(new_grid);
        switch (return_obj.status) {
          case "update":
            return return_obj;
          case "valid":
            return return_obj;
        }
        console.log("Returned to here. Following grid invalid.");
        console.log(new_grid);
      }
      return {
        status: "invalid"
      };
    };
    Solver.prototype.get_potentials = function(grid) {
      var cage, cand, cand_group, candidate, first_index, i, potentials, profitable_cage, smallest_cage, smallest_length, sq, square, temp, viable, viable_cage, _i, _j, _k, _l, _len, _len2, _len3, _len4, _len5, _m, _ref, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9;
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
      console.log("smallest_cage");
      console.log(smallest_cage);
      _ref3 = smallest_cage.candidates;
      for (cand_group in _ref3) {
        candidate = _ref3[cand_group];
        smallest_length = candidate.length;
        console.log(smallest_length);
      }
      _ref4 = grid.cages.slice(first_index + 1, grid.cages.length);
      for (_j = 0, _len2 = _ref4.length; _j < _len2; _j++) {
        cage = _ref4[_j];
        viable = false;
        _ref5 = cage.location;
        for (_k = 0, _len3 = _ref5.length; _k < _len3; _k++) {
          square = _ref5[_k];
          if (square.value === null) {
            viable = true;
            break;
          }
        }
        _ref6 = cage.candidates;
        for (cand_group in _ref6) {
          candidate = _ref6[cand_group];
          if (candidate.length < smallest_length && viable === true) {
            smallest_cage = cage;
            smallest_length = candidate.length;
          }
        }
      }
      profitable_cage = smallest_cage;
      _ref7 = profitable_cage.candidates;
      for (cand_group in _ref7) {
        cand = _ref7[cand_group];
        for (_l = 0, _len4 = cand.length; _l < _len4; _l++) {
          candidate = cand[_l];
          temp = new Grid(grid.size);
          jQuery.extend(true, temp, grid);
          _ref8 = temp.cages;
          for (_m = 0, _len5 = _ref8.length; _m < _len5; _m++) {
            cage = _ref8[_m];
            for (i = 0, _ref9 = cage.location.length; 0 <= _ref9 ? i < _ref9 : i > _ref9; 0 <= _ref9 ? i++ : i--) {
              cage.location[i] = temp.get_square(cage.location[i].id);
            }
            if (cage.id === profitable_cage.id) {
              temp.add_candidate(cage.location, candidate);
            }
          }
          potentials.push(this.clone(temp));
          temp = null;
        }
      }
      return potentials;
    };
    Solver.prototype.append_solution_order = function(fresh_vals) {};
    Solver.prototype.update_puzzle_info = function() {};
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
