(function() {
  var Cage;
  Cage = (function() {
    var arrayExcept, permute;
    Cage.prototype.id = null;
    Cage.prototype.target = null;
    Cage.prototype.operation = null;
    Cage.prototype.location = [];
    Cage.prototype.candidates = [];
    Cage.prototype.grid_size = null;
    function Cage(location) {
      this.location = location;
      this.id = uniqueId();
    }
    Cage.prototype.update_target = function(target) {
      return this.target = target;
    };
    Cage.prototype.update_operation = function(op) {
      return this.operation = op;
    };
    Cage.prototype.find_all_candidates = function(grid_size) {
      var i, output, single_candidate, _ref, _ref2, _ref3, _ref4, _results;
      this.grid_size = grid_size;
      output = "";
      this.candidates = [];
      switch (this.operation) {
        case "+":
          for (i = _ref = this.grid_size; _ref <= 1 ? i <= 1 : i >= 1; _ref <= 1 ? i++ : i--) {
            single_candidate = [];
            single_candidate.push(i);
            this.bt_plus(single_candidate, 1);
          }
          break;
        case "-":
          for (i = _ref2 = this.grid_size; _ref2 <= 1 ? i <= 1 : i >= 1; _ref2 <= 1 ? i++ : i--) {
            single_candidate = [];
            single_candidate.push(i);
            this.bt_minus(single_candidate, 1);
          }
          break;
        case "*":
          for (i = _ref3 = this.grid_size; _ref3 <= 1 ? i <= 1 : i >= 1; _ref3 <= 1 ? i++ : i--) {
            single_candidate = [];
            single_candidate.push(i);
            this.bt_multi(single_candidate, 1);
          }
          break;
        case "/":
          _results = [];
          for (i = _ref4 = this.grid_size; _ref4 <= 1 ? i <= 1 : i >= 1; _ref4 <= 1 ? i++ : i--) {
            single_candidate = [];
            single_candidate.push(i);
            _results.push(this.bt_divide(single_candidate, 1));
          }
          return _results;
      }
    };
    Cage.prototype.bt_plus = function(candidate, counter) {
      var new_branch, new_count, potentials, prev_vals, running_target, val, _i, _j, _len, _ref, _ref2, _results, _results2;
      running_target = this.target;
      for (prev_vals = 0, _ref = candidate.length; 0 <= _ref ? prev_vals < _ref : prev_vals > _ref; 0 <= _ref ? prev_vals++ : prev_vals--) {
        running_target -= candidate[prev_vals];
      }
      if (running_target < 0 || (running_target === 0 && counter !== this.location.length)) {
        return;
      }
      if (running_target === 0) {
        if (this.check_consistent(candidate) === true) {
          console.log("Candidate added!");
          this.candidates.push(candidate.slice(0, (candidate.length + 1) || 9e9));
        }
        return;
      }
      if (counter >= this.location.length) {
        return;
      }
      potentials = (function() {
        _results = [];
        for (var _i = _ref2 = this.grid_size; _ref2 <= 1 ? _i <= 1 : _i >= 1; _ref2 <= 1 ? _i++ : _i--){ _results.push(_i); }
        return _results;
      }).apply(this, arguments);
      _results2 = [];
      for (_j = 0, _len = potentials.length; _j < _len; _j++) {
        val = potentials[_j];
        new_branch = candidate;
        new_branch.push(val);
        new_count = counter + 1;
        this.bt_plus(new_branch, new_count);
        _results2.push(candidate.pop());
      }
      return _results2;
    };
    Cage.prototype.bt_minus = function(candidate, counter) {
      var new_branch, new_count, potentials, prev_vals, running_target, val, _i, _j, _len, _ref, _ref2, _results, _results2;
      running_target = candidate[0];
      for (prev_vals = 1, _ref = candidate.length; 1 <= _ref ? prev_vals < _ref : prev_vals > _ref; 1 <= _ref ? prev_vals++ : prev_vals--) {
        running_target -= candidate[prev_vals];
      }
      if (running_target < this.target || (running_target === this.target && counter !== this.location.length)) {
        return;
      }
      if (running_target === this.target) {
        if (this.check_consistent(candidate) === true) {
          console.log("Candidate added!");
          this.candidates.push(candidate.slice(0, (candidate.length + 1) || 9e9));
        }
        return;
      }
      if (counter >= this.location.length) {
        return;
      }
      potentials = (function() {
        _results = [];
        for (var _i = _ref2 = this.grid_size; _ref2 <= 1 ? _i <= 1 : _i >= 1; _ref2 <= 1 ? _i++ : _i--){ _results.push(_i); }
        return _results;
      }).apply(this, arguments);
      _results2 = [];
      for (_j = 0, _len = potentials.length; _j < _len; _j++) {
        val = potentials[_j];
        new_branch = candidate;
        new_branch.push(val);
        new_count = counter + 1;
        this.bt_minus(new_branch, new_count);
        _results2.push(candidate.pop());
      }
      return _results2;
    };
    Cage.prototype.bt_multi = function(candidate, counter) {
      var new_branch, new_count, potentials, prev_vals, running_target, val, _i, _j, _len, _ref, _ref2, _results, _results2;
      running_target = candidate[0];
      for (prev_vals = 1, _ref = candidate.length; 1 <= _ref ? prev_vals < _ref : prev_vals > _ref; 1 <= _ref ? prev_vals++ : prev_vals--) {
        running_target *= candidate[prev_vals];
      }
      if (running_target > this.target || (running_target === this.target && counter !== this.location.length)) {
        return;
      }
      if (running_target === this.target) {
        if (this.check_consistent(candidate) === true) {
          console.log("Candidate added!");
          this.candidates.push(candidate.slice(0, (candidate.length + 1) || 9e9));
        }
        return;
      }
      if (counter >= this.location.length) {
        return;
      }
      potentials = (function() {
        _results = [];
        for (var _i = _ref2 = this.grid_size; _ref2 <= 1 ? _i <= 1 : _i >= 1; _ref2 <= 1 ? _i++ : _i--){ _results.push(_i); }
        return _results;
      }).apply(this, arguments);
      _results2 = [];
      for (_j = 0, _len = potentials.length; _j < _len; _j++) {
        val = potentials[_j];
        new_branch = candidate;
        new_branch.push(val);
        new_count = counter + 1;
        this.bt_multi(new_branch, new_count);
        _results2.push(candidate.pop());
      }
      return _results2;
    };
    Cage.prototype.bt_divide = function(candidate, counter) {
      var i, new_branch, new_count, potentials, prev_vals, running_target, val, _i, _j, _len, _ref, _ref2, _results, _results2;
      running_target = candidate[0];
      for (prev_vals = 1, _ref = candidate.length; 1 <= _ref ? prev_vals < _ref : prev_vals > _ref; 1 <= _ref ? prev_vals++ : prev_vals--) {
        running_target /= candidate[prev_vals];
      }
      if (running_target < this.target) {
        return;
      }
      if (running_target === this.target) {
        if (counter !== this.location.length) {
          i = this.location.length;
          while (i !== counter) {
            candidate.push(1);
            i--;
          }
        }
        if (this.check_consistent(candidate) === true) {
          console.log("Candidate added!");
          this.candidates.push(candidate.slice(0, (candidate.length + 1) || 9e9));
        }
        return;
      }
      if (counter >= this.location.length) {
        return;
      }
      potentials = (function() {
        _results = [];
        for (var _i = _ref2 = this.grid_size; _ref2 <= 1 ? _i <= 1 : _i >= 1; _ref2 <= 1 ? _i++ : _i--){ _results.push(_i); }
        return _results;
      }).apply(this, arguments);
      _results2 = [];
      for (_j = 0, _len = potentials.length; _j < _len; _j++) {
        val = potentials[_j];
        new_branch = candidate;
        new_branch.push(val);
        new_count = counter + 1;
        this.bt_divide(new_branch, new_count);
        _results2.push(candidate.pop());
      }
      return _results2;
    };
    Cage.prototype.check_consistent = function(candidate) {
      var cmp_col, cmp_row, col, i, j, row, _ref, _ref2, _ref3;
      if (candidate.length === 1) {
        return true;
      } else {
        for (i = 0, _ref = candidate.length; 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
          row = this.location[i].row_id_char;
          col = this.location[i].column_id + 1;
          console.log("row=" + row + ", col=" + col);
          for (j = _ref2 = i + 1, _ref3 = candidate.length; _ref2 <= _ref3 ? j < _ref3 : j > _ref3; _ref2 <= _ref3 ? j++ : j--) {
            if (!(candidate[j] != null)) {
              break;
            }
            cmp_row = this.location[j].row_id_char;
            cmp_col = this.location[j].column_id + 1;
            console.log("   cmp_row=" + cmp_row + ", cmp_col=" + cmp_col);
            if (cmp_row === row || cmp_col === col) {
              console.log("      candidate[i]=" + candidate[i] + ", candidate[j]=" + candidate[j]);
              if (candidate[i] === candidate[j]) {
                console.log("      ERROR: inconsistent");
                return false;
              } else {
                console.log("      Consistent");
              }
            }
          }
        }
        return true;
      }
    };
    Cage.prototype.add_candidate_to_grid = function(candidate) {};
    arrayExcept = function(arr, idx) {
      var res;
      res = arr.slice(0);
      res.splice(idx, 1);
      return res;
    };
    permute = function(arr, grid_size) {
      var idx, perm, permutations, value, _ref;
      arr = Array.prototype.slice.call(arr, 0);
      if (arr.length === 0) {
        return [[]];
      }
      permutations = (function() {
        var _len, _results;
        _results = [];
        for (idx = 0, _len = arr.length; idx < _len; idx++) {
          value = arr[idx];
          _results.push((function() {
            var _i, _len2, _ref, _results2;
            _ref = permute(arrayExcept(arr, idx));
            _results2 = [];
            for (_i = 0, _len2 = _ref.length; _i < _len2; _i++) {
              perm = _ref[_i];
              _results2.push([value].concat(perm));
            }
            return _results2;
          })());
        }
        return _results;
      })();
      return (_ref = []).concat.apply(_ref, permutations);
    };
    return Cage;
  })();
  this.Cage = Cage;
}).call(this);
