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
      var output, single_candidate;
      this.grid_size = grid_size;
      output = "";
      switch (this.operation) {
        case "+":
          single_candidate = [];
          single_candidate.push(7);
          return this.bt_plus(single_candidate, 0);
        case "-":
          return this.candidates_minus(grid_size);
        case "*":
          return this.candidates_multi(grid_size);
        case "/":
          return this.candidates_divide(grid_size);
      }
    };
    Cage.prototype.bt_plus = function(candidate, counter) {
      var new_branch, potentials, prev_vals, running_target, val, _i, _len, _ref, _results;
      running_target = candidate[0];
      console.log("candidate =  " + candidate + ", counter = " + counter);
      for (prev_vals = 1, _ref = candidate.length; 1 <= _ref ? prev_vals < _ref : prev_vals > _ref; 1 <= _ref ? prev_vals++ : prev_vals--) {
        running_target -= candidate[prev_vals];
      }
      console.log(running_target);
      if (running_target < 0 || (running_target === 0 && counter !== this.location.length)) {
        console.log("invalid");
        return;
      }
      if (running_target === 0) {
        console.log("######valid");
        console.log(candidate.slice(1, (candidate.length + 1) || 9e9));
        this.candidates.push(candidate.slice(1, (candidate.length + 1) || 9e9));
        return;
      }
      potentials = [2, 1];
      _results = [];
      for (_i = 0, _len = potentials.length; _i < _len; _i++) {
        val = potentials[_i];
        new_branch = candidate;
        new_branch.push(val);
        console.log("the candidate entering bt() is " + candidate);
        this.bt_plus(new_branch, ++counter);
        _results.push(candidate.pop());
      }
      return _results;
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
