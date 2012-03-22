(function() {
  var Cage;
  Cage = (function() {
    Cage.prototype.id = null;
    Cage.prototype.target = null;
    Cage.prototype.operation = null;
    Cage.prototype.location = [];
    Cage.prototype.candidates = [];
    function Cage(location) {
      this.location = location;
    }
    Cage.prototype.find_all_candidates = function() {};
    return Cage;
  })();
  this.Cage = Cage;
}).call(this);
