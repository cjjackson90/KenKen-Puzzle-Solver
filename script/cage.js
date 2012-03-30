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
      var i, output, single_candidate, _ref, _ref2, _ref3, _results;
      this.grid_size = grid_size;
      output = "";
      this.candidates = [];
      switch (this.operation) {
        case "+":
          console.log("******NEW + ********");
          single_candidate = [];
          single_candidate.push(this.target);
          this.bt_plus(single_candidate, 0);
          console.log("location.length = " + this.location.length + ", candidates=");
          console.log(this.candidates);
          break;
        case "-":
          console.log("********* minus");
          for (i = _ref = this.grid_size; _ref <= 1 ? i <= 1 : i >= 1; _ref <= 1 ? i++ : i--) {
            single_candidate = [];
            single_candidate.push(i);
            this.bt_minus(single_candidate, 1);
          }
          break;
        case "*":
          console.log("********* multiply");
          for (i = _ref2 = this.grid_size; _ref2 <= 1 ? i <= 1 : i >= 1; _ref2 <= 1 ? i++ : i--) {
            single_candidate = [];
            single_candidate.push(i);
            this.bt_multi(single_candidate, 1);
          }
          break;
        case "/":
          console.log("/////////// divide");
          _results = [];
          for (i = _ref3 = this.grid_size; _ref3 <= 1 ? i <= 1 : i >= 1; _ref3 <= 1 ? i++ : i--) {
            single_candidate = [];
            single_candidate.push(i);
            _results.push(this.bt_divide(single_candidate, 1));
          }
          return _results;
      }
    };
    Cage.prototype.bt_plus = function(candidate, counter) {
      var new_branch, new_count, potentials, prev_vals, running_target, val, _i, _j, _len, _ref, _ref2, _results, _results2;
      running_target = candidate[0];
      for (prev_vals = 1, _ref = candidate.length; 1 <= _ref ? prev_vals < _ref : prev_vals > _ref; 1 <= _ref ? prev_vals++ : prev_vals--) {
        running_target -= candidate[prev_vals];
      }
      if (running_target < 0 || (running_target === 0 && counter !== this.location.length)) {
        return;
      }
      if (running_target === 0) {
        this.candidates.push(candidate.slice(1, (candidate.length + 1) || 9e9));
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
      console.log("candidate =  " + candidate + ", counter = " + counter);
      for (prev_vals = 1, _ref = candidate.length; 1 <= _ref ? prev_vals < _ref : prev_vals > _ref; 1 <= _ref ? prev_vals++ : prev_vals--) {
        running_target -= candidate[prev_vals];
      }
      if (running_target < this.target || (running_target === this.target && counter !== this.location.length)) {
        return;
      }
      if (running_target === this.target) {
        this.candidates.push(candidate.slice(0, candidate.length));
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
        console.log("the candidate entering bt() is " + candidate);
        this.bt_minus(new_branch, new_count);
        _results2.push(candidate.pop());
      }
      return _results2;
    };
    Cage.prototype.bt_multi = function(candidate, counter) {
      var new_branch, new_count, potentials, prev_vals, running_target, val, _i, _j, _len, _ref, _ref2, _results, _results2;
      running_target = candidate[0];
      console.log("candidate =  " + candidate + ", counter = " + counter);
      for (prev_vals = 1, _ref = candidate.length; 1 <= _ref ? prev_vals < _ref : prev_vals > _ref; 1 <= _ref ? prev_vals++ : prev_vals--) {
        running_target *= candidate[prev_vals];
      }
      if (running_target > this.target || (running_target === this.target && counter !== this.location.length)) {
        console.log("invalid");
        return;
      }
      if (running_target === this.target) {
        console.log("######valid");
        this.candidates.push(candidate.slice(0, candidate.length));
        return;
      }
      console.log("location.length = " + this.location.length + ", counter=" + counter);
      if (counter >= this.location.length) {
        console.log("invalid 2");
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
        console.log("the candidate entering bt() is " + candidate);
        this.bt_multi(new_branch, new_count);
        _results2.push(candidate.pop());
      }
      return _results2;
    };
    Cage.prototype.bt_divide = function(candidate, counter) {
      var i, new_branch, new_count, potentials, prev_vals, running_target, val, _i, _j, _len, _ref, _ref2, _results, _results2;
      running_target = candidate[0];
      console.log("candidate =  " + candidate + ", counter = " + counter);
      for (prev_vals = 1, _ref = candidate.length; 1 <= _ref ? prev_vals < _ref : prev_vals > _ref; 1 <= _ref ? prev_vals++ : prev_vals--) {
        running_target /= candidate[prev_vals];
      }
      console.log(running_target);
      if (running_target < this.target) {
        console.log("invalid");
        return;
      }
      if (running_target === this.target) {
        console.log("######valid");
        if (counter !== this.location.length) {
          i = this.location.length;
          console.log("location.length = " + this.location.length + ", " + i + ", " + counter);
          while (i !== counter) {
            candidate.push(1);
            i--;
          }
          console.log("candidate = " + candidate);
        }
        this.candidates.push(candidate.slice(0, candidate.length));
        return;
      }
      console.log("location.length = " + this.location.length + ", counter=" + counter);
      if (counter >= this.location.length) {
        console.log("invalid 2");
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
        console.log("the candidate entering bt() is " + candidate);
        this.bt_divide(new_branch, new_count);
        _results2.push(candidate.pop());
      }
      return _results2;
    };
    Cage.prototype.candidates_plus = function(n, output) {
      var current, temp, _results;
      console.log(n);
      if ((n <= 0) && (output.length < this.grid_size)) {
        return null;
      } else if (n === 0) {
        return output;
      } else {
        current = n > this.grid_size ? this.grid_size : n;
        console.log(current);
        _results = [];
        while (current > 0) {
          console.log(output);
          temp = this.candidates_plus(n - current, output);
          _results.push(current--);
        }
        return _results;
      }
    };
    Cage.prototype.candidates_minus = function(grid_size) {};
    Cage.prototype.candidates_multi = function(grid_size) {};
    Cage.prototype.candidates_divide = function(grid_size) {};
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
