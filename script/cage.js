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
      this.id = uniqueId();
      this.location = location;
    }
    Cage.prototype.update_square_cage_ids = function() {
      var square, _i, _len, _ref, _results;
      _ref = this.location;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        square = _ref[_i];
        _results.push(square.set_cage_id(this.id));
      }
      return _results;
    };
    Cage.prototype.update_target = function(target) {
      this.target = target;
    };
    Cage.prototype.update_operation = function(operation) {
      this.operation = operation;
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
    Cage.prototype.remove_duplicates = function(candidate) {
      var foo;
      if (candidate != null) {
        foo = candidate;
        foo.unique();
        return this.candidates = foo;
      }
    };
    Cage.prototype.bt_plus = function(candidate, counter) {
      var n, new_branch, new_candidates, new_count, no_solutions, perms, permutation, potentials, prev_vals, running_target, val, _i, _j, _k, _len, _len2, _ref, _results;
      running_target = this.target;
      if (candidate[0] * this.location.length < this.target) {
        return;
      }
      if (candidate[0] + this.location.length - 1 > this.target) {
        return;
      }
      for (prev_vals = 0, _ref = candidate.length; 0 <= _ref ? prev_vals < _ref : prev_vals > _ref; 0 <= _ref ? prev_vals++ : prev_vals--) {
        running_target -= candidate[prev_vals];
      }
      if (running_target < 0 || (running_target === 0 && counter !== this.location.length)) {
        return;
      }
      if (running_target === 0) {
        perms = permute(candidate, this.grid_size);
        for (_i = 0, _len = perms.length; _i < _len; _i++) {
          permutation = perms[_i];
          if (this.check_consistent(permutation)) {
            this.candidates.push(permutation);
          }
        }
        new_candidates = this.unique(this.candidates);
        this.candidates = new_candidates;
        return;
      }
      if (counter >= this.location.length) {
        return;
      }
      n = candidate[candidate.length - 1] < this.grid_size ? candidate[candidate.length - 1] : this.grid_size;
      no_solutions = 1;
      potentials = (function() {
        _results = [];
        for (var _j = n; n <= 1 ? _j <= 1 : _j >= 1; n <= 1 ? _j++ : _j--){ _results.push(_j); }
        return _results;
      }).apply(this, arguments);
      for (_k = 0, _len2 = potentials.length; _k < _len2; _k++) {
        val = potentials[_k];
        new_branch = candidate;
        new_branch.push(val);
        new_count = counter + 1;
        this.bt_plus(new_branch, new_count);
        candidate.pop();
      }
    };
    Cage.prototype.bt_minus = function(candidate, counter) {
      var n, new_branch, new_candidates, new_count, perms, permutation, potentials, prev_vals, running_target, val, _i, _j, _k, _len, _len2, _ref, _results, _results2;
      running_target = candidate[0];
      if (candidate[0] < this.target) {
        return;
      }
      for (prev_vals = 1, _ref = candidate.length; 1 <= _ref ? prev_vals < _ref : prev_vals > _ref; 1 <= _ref ? prev_vals++ : prev_vals--) {
        running_target -= candidate[prev_vals];
      }
      if (running_target < this.target || (running_target === this.target && counter !== this.location.length)) {
        return;
      }
      if (running_target === this.target) {
        perms = permute(candidate, this.grid_size);
        for (_i = 0, _len = perms.length; _i < _len; _i++) {
          permutation = perms[_i];
          if (this.check_consistent(permutation)) {
            this.candidates.push(permutation);
          }
        }
        new_candidates = this.unique(this.candidates);
        this.candidates = new_candidates;
        return;
      }
      if (counter >= this.location.length) {
        return;
      }
      n = candidate[candidate.length - 1] < this.grid_size ? candidate[candidate.length - 1] : this.grid_size;
      potentials = (function() {
        _results = [];
        for (var _j = n; n <= 1 ? _j <= 1 : _j >= 1; n <= 1 ? _j++ : _j--){ _results.push(_j); }
        return _results;
      }).apply(this, arguments);
      _results2 = [];
      for (_k = 0, _len2 = potentials.length; _k < _len2; _k++) {
        val = potentials[_k];
        new_branch = candidate;
        new_branch.push(val);
        new_count = counter + 1;
        this.bt_minus(new_branch, new_count);
        _results2.push(candidate.pop());
      }
      return _results2;
    };
    Cage.prototype.bt_multi = function(candidate, counter) {
      var i, k, n, new_branch, new_candidates, new_count, perms, permutation, pop_counter, potentials, prev_vals, running_target, val, _i, _j, _k, _len, _len2, _ref, _results;
      running_target = candidate[0];
      for (prev_vals = 1, _ref = candidate.length; 1 <= _ref ? prev_vals < _ref : prev_vals > _ref; 1 <= _ref ? prev_vals++ : prev_vals--) {
        running_target *= candidate[prev_vals];
      }
      if (running_target > this.target || candidate.length > this.location.length) {
        return 1;
      }
      if (running_target === this.target) {
        pop_counter = 1;
        if (counter !== this.location.length) {
          i = this.location.length;
          while (i !== counter) {
            candidate.push(1);
            i--;
            ++pop_counter;
          }
        }
        perms = permute(candidate, this.grid_size);
        for (_i = 0, _len = perms.length; _i < _len; _i++) {
          permutation = perms[_i];
          if (this.check_consistent(permutation)) {
            this.candidates.push(permutation);
          }
        }
        new_candidates = this.unique(this.candidates);
        this.candidates = new_candidates;
        return pop_counter;
      }
      if (counter >= this.location.length) {
        return 1;
      }
      n = candidate[candidate.length - 1] < this.grid_size ? candidate[candidate.length - 1] : this.grid_size;
      potentials = (function() {
        _results = [];
        for (var _j = n; n <= 2 ? _j <= 2 : _j >= 2; n <= 2 ? _j++ : _j--){ _results.push(_j); }
        return _results;
      }).apply(this, arguments);
      for (_k = 0, _len2 = potentials.length; _k < _len2; _k++) {
        val = potentials[_k];
        new_branch = candidate;
        new_branch.push(val);
        new_count = counter + 1;
        k = this.bt_multi(new_branch, new_count);
        while (k !== 0) {
          candidate.pop();
          k--;
        }
      }
      return 1;
    };
    Cage.prototype.bt_divide = function(candidate, counter) {
      var i, n, new_branch, new_candidates, new_count, perms, permutation, potentials, prev_vals, running_target, val, _i, _j, _k, _len, _len2, _ref, _results, _results2;
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
        perms = permute(candidate, this.grid_size);
        for (_i = 0, _len = perms.length; _i < _len; _i++) {
          permutation = perms[_i];
          this.candidates.push(permutation);
        }
        new_candidates = this.unique(this.candidates);
        this.candidates = new_candidates;
        return;
      }
      if (counter >= this.location.length) {
        return;
      }
      n = candidate[candidate.length - 1] < this.grid_size ? candidate[candidate.length - 1] : this.grid_size;
      potentials = (function() {
        _results = [];
        for (var _j = n; n <= 1 ? _j <= 1 : _j >= 1; n <= 1 ? _j++ : _j--){ _results.push(_j); }
        return _results;
      }).apply(this, arguments);
      _results2 = [];
      for (_k = 0, _len2 = potentials.length; _k < _len2; _k++) {
        val = potentials[_k];
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
          for (j = _ref2 = i + 1, _ref3 = candidate.length; _ref2 <= _ref3 ? j < _ref3 : j > _ref3; _ref2 <= _ref3 ? j++ : j--) {
            if (!(candidate[j] != null)) {
              break;
            }
            cmp_row = this.location[j].row_id_char;
            cmp_col = this.location[j].column_id + 1;
            if (cmp_row === row || cmp_col === col) {
              if (candidate[i] === candidate[j]) {
                return false;
              } else {

              }
            }
          }
        }
        return true;
      }
    };
    Cage.prototype.add_candidate_to_grid = function(candidate) {
      var i, _ref, _results;
      _results = [];
      for (i = 0, _ref = this.location.length; 0 <= _ref ? i < _ref : i > _ref; 0 <= _ref ? i++ : i--) {
        _results.push(this.location[i].set_value(candidate[i]));
      }
      return _results;
    };
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
    Cage.prototype.unique = function(array) {
      var key, output, value, _ref, _results;
      output = {};
      for (key = 0, _ref = array.length; 0 <= _ref ? key < _ref : key > _ref; 0 <= _ref ? key++ : key--) {
        output[array[key]] = array[key];
      }
      _results = [];
      for (key in output) {
        value = output[key];
        _results.push(value);
      }
      return _results;
    };
    return Cage;
  })();
  this.Cage = Cage;
}).call(this);
