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
    Grid.prototype.add_candidate = function(location, candidate) {
      var col_id, current_cmp, i, row_id, _ref, _results;
      _results = [];
      for (i = 0, _ref = location.length; 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
        current_cmp = this.display[location[i].row_id][location[i].column_id];
        _results.push(current_cmp.id === location[i].id ? (current_cmp.set_value(candidate[i]), row_id = current_cmp.row_id, col_id = current_cmp.column_id, this.update_row(row_id, candidate[i]), this.update_column(col_id, candidate[i])) : void 0);
      }
      return _results;
    };
    Grid.prototype.draw = function() {};
    Grid.prototype.clear = function() {};
    Grid.prototype.update_row = function(row_id, val) {
      return this.rows[row_id][val - 1] = null;
    };
    Grid.prototype.update_column = function(col_id, val) {
      return this.columns[col_id][val - 1] = null;
    };
    Grid.prototype.update_affected_candidates = function(update_type, new_sq, value) {
      /* update type determines whether row, column or both are
      			updated. Row/Column would be updated depending on if a
      			value is known to go in a particular row/column but not
      			where. Both is used if the value is in place and thus
      			affects both row and column.
      			0 = both
      			1 = row
      			2 = column
      		*/      var affected_cage, affected_col, affected_row, cage, cand, cand_group, candidate, i, loc_index, output, rem_array, square, _i, _j, _k, _l, _len, _len2, _len3, _len4, _len5, _len6, _len7, _len8, _m, _n, _o, _p, _ref, _ref10, _ref11, _ref12, _ref13, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9, _results, _results2, _results3;
      switch (update_type) {
        case 0:
          affected_row = new_sq.row_id;
          affected_col = new_sq.column_id;
          _ref = this.display[affected_row];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            square = _ref[_i];
            _ref2 = this.cages;
            for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
              cage = _ref2[_j];
              if (cage.id === square.cage_id) {
                affected_cage = cage;
                for (i = 0, _ref3 = affected_cage.location.length; 0 <= _ref3 ? i < _ref3 : i > _ref3; 0 <= _ref3 ? i++ : i--) {
                  if (affected_cage.location[i] === square) {
                    loc_index = i;
                  }
                }
              }
            }
            _ref4 = affected_cage.candidates;
            for (cand_group in _ref4) {
              cand = _ref4[cand_group];
              rem_array = [];
              for (_k = 0, _len3 = cand.length; _k < _len3; _k++) {
                candidate = cand[_k];
                if (candidate[loc_index] === new_sq.value) {
                  rem_array.push(candidate);
                }
              }
              if (rem_array.length !== 0) {
                output = affected_cage.candidates[cand_group];
                for (_l = 0, _len4 = rem_array.length; _l < _len4; _l++) {
                  candidate = rem_array[_l];
                  output = this.remove(output, candidate);
                }
                affected_cage.candidates[cand_group] = output;
              }
            }
          }
          _results = [];
          for (i = 0, _ref5 = this.size; 0 <= _ref5 ? i < _ref5 : i > _ref5; 0 <= _ref5 ? i++ : i--) {
            square = this.display[i][affected_col];
            _ref6 = this.cages;
            for (_m = 0, _len5 = _ref6.length; _m < _len5; _m++) {
              cage = _ref6[_m];
              if (cage.id === square.cage_id) {
                affected_cage = cage;
                for (i = 0, _ref7 = affected_cage.location.length; 0 <= _ref7 ? i < _ref7 : i > _ref7; 0 <= _ref7 ? i++ : i--) {
                  if (affected_cage.location[i] === square) {
                    loc_index = i;
                  }
                }
              }
            }
            _results.push((function() {
              var _len6, _n, _ref8, _results2;
              _ref8 = affected_cage.candidates;
              _results2 = [];
              for (cand_group in _ref8) {
                cand = _ref8[cand_group];
                rem_array = [];
                for (_n = 0, _len6 = cand.length; _n < _len6; _n++) {
                  candidate = cand[_n];
                  if (candidate[loc_index] === new_sq.value) {
                    rem_array.push(candidate);
                  }
                }
                _results2.push((function() {
                  var _len7, _o;
                  if (rem_array.length !== 0) {
                    output = affected_cage.candidates[cand_group];
                    for (_o = 0, _len7 = rem_array.length; _o < _len7; _o++) {
                      candidate = rem_array[_o];
                      output = this.remove(output, candidate);
                    }
                    return affected_cage.candidates[cand_group] = output;
                  }
                }).call(this));
              }
              return _results2;
            }).call(this));
          }
          return _results;
          break;
        case 1:
          affected_row = new_sq.row_id;
          _ref8 = this.display[affected_row];
          _results2 = [];
          for (_n = 0, _len6 = _ref8.length; _n < _len6; _n++) {
            square = _ref8[_n];
            _ref9 = this.cages;
            for (_o = 0, _len7 = _ref9.length; _o < _len7; _o++) {
              cage = _ref9[_o];
              if (cage.id === square.cage_id) {
                affected_cage = cage;
                for (i = 0, _ref10 = affected_cage.location.length; 0 <= _ref10 ? i < _ref10 : i > _ref10; 0 <= _ref10 ? i++ : i--) {
                  if (affected_cage.location[i] === square) {
                    loc_index = i;
                  }
                }
              }
            }
            _results2.push((function() {
              var _len8, _p, _ref11, _results3;
              _ref11 = affected_cage.candidates;
              _results3 = [];
              for (cand_group in _ref11) {
                cand = _ref11[cand_group];
                rem_array = [];
                for (_p = 0, _len8 = cand.length; _p < _len8; _p++) {
                  candidate = cand[_p];
                  if (candidate[loc_index] === new_sq.value) {
                    rem_array.push(candidate);
                  }
                }
                _results3.push((function() {
                  var _len9, _q;
                  if (rem_array.length !== 0) {
                    output = affected_cage.candidates[cand_group];
                    for (_q = 0, _len9 = rem_array.length; _q < _len9; _q++) {
                      candidate = rem_array[_q];
                      output = this.remove(output, candidate);
                    }
                    return affected_cage.candidates[cand_group] = output;
                  }
                }).call(this));
              }
              return _results3;
            }).call(this));
          }
          return _results2;
          break;
        case 2:
          affected_col = new_sq.column_id;
          _results3 = [];
          for (i = 0, _ref11 = this.size; 0 <= _ref11 ? i < _ref11 : i > _ref11; 0 <= _ref11 ? i++ : i--) {
            square = this.display[i][affected_col];
            _ref12 = this.cages;
            for (_p = 0, _len8 = _ref12.length; _p < _len8; _p++) {
              cage = _ref12[_p];
              if (cage.id === square.cage_id) {
                affected_cage = cage;
                for (i = 0, _ref13 = affected_cage.location.length; 0 <= _ref13 ? i < _ref13 : i > _ref13; 0 <= _ref13 ? i++ : i--) {
                  if (affected_cage.location[i] === square) {
                    loc_index = i;
                  }
                }
              }
            }
            _results3.push((function() {
              var _len9, _q, _ref14, _results4;
              _ref14 = affected_cage.candidates;
              _results4 = [];
              for (cand_group in _ref14) {
                cand = _ref14[cand_group];
                rem_array = [];
                for (_q = 0, _len9 = cand.length; _q < _len9; _q++) {
                  candidate = cand[_q];
                  if (candidate[loc_index] === new_sq.value) {
                    rem_array.push(candidate);
                  }
                }
                _results4.push((function() {
                  var _len10, _r;
                  if (rem_array.length !== 0) {
                    output = affected_cage.candidates[cand_group];
                    for (_r = 0, _len10 = rem_array.length; _r < _len10; _r++) {
                      candidate = rem_array[_r];
                      output = this.remove(output, candidate);
                    }
                    return affected_cage.candidates[cand_group] = output;
                  }
                }).call(this));
              }
              return _results4;
            }).call(this));
          }
          return _results3;
      }
    };
    Grid.prototype.add_cage = function(cage) {
      return this.cages.push(cage);
    };
    Grid.prototype.remove_cage = function() {};
    Grid.prototype.add_solution = function(solution) {
      return this.solution = solution;
    };
    Grid.prototype.verify_correct = function() {
      var i, _ref, _results;
      console.log(this.solution);
      if (this.solution.length === []) {
        console.log("shouldn't be here...");
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
        if (this.check_rows_are_valid() === false) {
          console.log("rows invalid");
          return false;
        }
        if (this.check_cols_are_valid() === false) {
          console.log("cols invalid");
          return false;
        }
        if (this.check_cages_are_valid() === false) {
          console.log("cages invalid");
          return false;
        }
        return true;
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
