/// Encapsulates all Cell activity and data.
class Cell {
  num state = 1; // Alive (1) or dead (0)
  num nextState = 0;
  num neighbors = 0; // Living neighbors
  var neighborsList = []; // List of neighbors
  num coordX = 0;
  num coordY = 0;

  /// Check the neighbors and change state accordingly.
  void check() {
    this.checkNeighbors();
    this.nextState = this.tick();
  }

  /// Change to the next state.
  void grow() {
    this.state = this.nextState;
  }

  /// Get the cell's name.
  String getName() {
    return '(' + this.coordX.toString() + ',' + this.coordY.toString() + ')';
  }

  /// Connect two cells as neighbors.
  void connect(Cell N) {
    if (this.neighborsList.indexOf(N) == -1) {
      this.neighborsList.add(N);
      // N.connect(this); // Not sure if this has a benefit
    }
  }

  /// Check neighbors for life.
  void checkNeighbors() {
    this.neighbors = 0;

    for (var neighbor in this.neighborsList) {
      if (neighbor.state == 1) {
        this.neighbors = this.neighbors + 1;
      }
    }
    // if (state == 1) {
    //   print("Cell: ${this.getName()}, State: ${this.state}, ${this.neighborsList.length}(${this.neighbors})");
    //   for(Cell n in this.neighborsList){
    //     print("${n.getName()}: ${n.state}");
    //   }
    // }
  }

  /// Get the new status of the cell (alive or dead).
  /// A 'tick' is one life-cycle.
  num tick() {
    if (this.state == 1) {
      if (this.neighbors < 2) {
        return 0; // dead
      }
      if (this.neighbors == 2 || this.neighbors == 3) {
        return 1; // alive
      }
      if (this.neighbors > 3) {
        return 0; // dead
      }
    } else {
      if (this.neighbors == 3) {
        return 1; // reborn
      }
    }
    return 0;
  }
}
