(function() {
  var Strategies;
  var __indexOf = Array.prototype.indexOf || function(item) {
    for (var i = 0, l = this.length; i < l; i++) {
      if (this[i] === item) return i;
    }
    return -1;
  };
  Strategies = (function() {
    function Strategies() {}
    Strategies.prototype.one_candidate = function(grid) {
      var cage, new_grid, return_obj, sq, valid, vals, vals_added, _i, _j, _k, _len, _len2, _len3, _ref, _ref2, _ref3;
      vals_added = false;
      vals = [];
      new_grid = grid;
      _ref = new_grid.cages;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        cage = _ref[_i];
        if (cage.candidates.length === 1) {
          valid = false;
          _ref2 = cage.location;
          for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
            sq = _ref2[_j];
            if (sq.value === null) {
              valid = true;
              break;
            }
          }
          if (valid) {
            cage.add_candidate_to_grid(cage.candidates[0]);
            _ref3 = cage.location;
            for (_k = 0, _len3 = _ref3.length; _k < _len3; _k++) {
              sq = _ref3[_k];
              vals.push(sq);
            }
            vals_added = true;
          }
        }
      }
      return_obj = {
        status: vals_added,
        vals: vals,
        grid: new_grid
      };
      return return_obj;
      return false;
    };
    Strategies.prototype.common_numbers = function(grid) {
      var cage, candidate, col_id, foo, included, output, potentials, rem_obj, return_obj, row_id, same_col, same_row, sq, temp, val, _i, _j, _k, _l, _len, _len10, _len11, _len12, _len2, _len3, _len4, _len5, _len6, _len7, _len8, _len9, _m, _n, _o, _p, _q, _r, _ref, _ref2, _ref3, _ref4, _s, _t;
      _ref = grid.cages;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        cage = _ref[_i];
        if (cage.candidates.length === 0) {
          continue;
        }
        if (cage.candidates[0].length > grid.size) {
          continue;
        }
        same_row = true;
        same_col = true;
        row_id = cage.location[0].row_id;
        col_id = cage.location[0].column_id;
        _ref2 = cage.location;
        for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
          sq = _ref2[_j];
          if (sq.row_id !== row_id) {
            same_row = false;
          }
          if (sq.col_id !== col_id) {
            same_col = false;
          }
          if (same_row === false && same_col === false) {
            return_obj = {
              status: false
            };
          }
        }
        if (same_row) {
          console.log(cage.candidates);
          potentials = cage.candidates[0];
          console.log("potentials");
          console.log(potentials);
          temp = [];
          for (_k = 0, _len3 = potentials.length; _k < _len3; _k++) {
            val = potentials[_k];
            console.log("val = " + val);
            console.log("value of grid.rows[" + row_id + "][" + (val - 1) + "] = " + grid.rows[row_id][val - 1]);
            if (grid.rows[row_id][val - 1] === null) {
              temp.push(this.remove(potentials, val));
            }
          }
          console.log(temp);
          for (_l = 0, _len4 = temp.length; _l < _len4; _l++) {
            val = temp[_l];
            console.log("removing " + val + " from " + potentials);
            foo = this.remove(potentials, val[0]);
            potentials = foo;
            console.log(potentials);
          }
          if (potentials.length === 0) {
            continue;
          }
          _ref3 = cage.candidates.slice(1, cage.candidates.length);
          for (_m = 0, _len5 = _ref3.length; _m < _len5; _m++) {
            candidate = _ref3[_m];
            for (_n = 0, _len6 = potentials.length; _n < _len6; _n++) {
              val = potentials[_n];
              if ((included = __indexOf.call(candidate, val) >= 0) === false) {
                potentials = this.remove(potentials, val);
              }
            }
          }
          console.log("potentials reduced");
          console.log(potentials);
          if (potentials.length > 0) {
            output = [];
            for (_o = 0, _len7 = potentials.length; _o < _len7; _o++) {
              val = potentials[_o];
              rem_obj = {
                row_or_col: "row",
                id: row_id,
                cage_id: cage.id,
                val: val
              };
              output.push(rem_obj);
            }
          }
          return_obj = {
            status: potentials.length > 0,
            vals: output,
            grid: grid
          };
          return return_obj;
        }
        if (same_col) {
          console.log(cage.candidates);
          potentials = cage.candidates[0];
          console.log("potentials");
          console.log(potentials);
          temp = [];
          for (_p = 0, _len8 = potentials.length; _p < _len8; _p++) {
            val = potentials[_p];
            console.log("val = " + val);
            console.log("value of grid.columns[" + col_id + "][" + (val - 1) + "] = " + grid.columns[col_id][val - 1]);
            if (grid.columns[col_id][val - 1] === null) {
              temp.push(this.remove(potentials, val));
            }
          }
          console.log(temp);
          for (_q = 0, _len9 = temp.length; _q < _len9; _q++) {
            val = temp[_q];
            console.log("removing " + val + " frp, " + potentials);
            foo = this.remove(potentials, val[0]);
            potentials = foo;
            console.log(potentials);
          }
          if (potentials.length === 0) {
            continue;
          }
          _ref4 = cage.candidates.slice(1, cage.candidates.length);
          for (_r = 0, _len10 = _ref4.length; _r < _len10; _r++) {
            candidate = _ref4[_r];
            for (_s = 0, _len11 = potentials.length; _s < _len11; _s++) {
              val = potentials[_s];
              if ((included = __indexOf.call(candidates, val) >= 0) === false) {
                potentials = this.remove(potentials, val);
              }
            }
          }
          console.log("potentials reduced");
          console.log(potentials);
          if (potentials.length > 0) {
            output = [];
            for (_t = 0, _len12 = potentials.length; _t < _len12; _t++) {
              val = potentials[_t];
              rem_obj = {
                row_or_col: "col",
                id: col_id,
                cage_id: cage.id,
                val: val
              };
              output.push(rem_obj);
            }
          }
          return_obj = {
            status: potentials.length > 0,
            vals: output,
            grid: grid
          };
          return return_obj;
        }
      }
      return_obj = {
        status: "debug",
        grid: grid
      };
      return return_obj;
    };
    Strategies.prototype.certain_vals = function(grid) {
      return false;
    };
    Strategies.prototype.remove = function(arr, val) {
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
    return Strategies;
  })();
  this.Strategies = Strategies;
}).call(this);
