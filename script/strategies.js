(function() {
  var Strategies;
  Strategies = (function() {
    function Strategies() {}
    Strategies.prototype.one_candidate = function(grid) {
      var cage, return_obj, sq, valid, vals, vals_added, _i, _j, _k, _len, _len2, _len3, _ref, _ref2, _ref3;
      vals_added = false;
      vals = [];
      _ref = grid.cages;
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
        grid: grid
      };
      return return_obj;
      return false;
    };
    Strategies.prototype.common_numbers = function(grid) {
      return false;
    };
    Strategies.prototype.certain_vals = function(grid) {
      return false;
    };
    return Strategies;
  })();
  this.Strategies = Strategies;
}).call(this);
