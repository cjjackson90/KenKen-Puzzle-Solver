(function() {
  var Square;
  Square = (function() {
    Square.prototype.id = null;
    Square.prototype.target_op = null;
    Square.prototype.value = null;
    Square.prototype.row_id = null;
    Square.prototype.column_id = null;
    Square.prototype.cage_id = null;
    function Square(row_id, column_id) {
      this.row_id = row_id;
      this.column_id = column_id;
      this.id = (String.fromCharCode(row_id + 97)) + (column_id + 1);
    }
    Square.prototype.set_cage_id = function(cage_id) {};
    Square.prototype.set_value = function(new_val) {};
    Square.prototype.set_target_op = function(target_val, op) {};
    return Square;
  })();
  this.Square = Square;
}).call(this);
