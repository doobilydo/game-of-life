/// Encapsulates all Cell activity and data.
class Cell {
  int state = 1; // Alive (1) or dead (0)
  int nextState = 0;
  int neighbors = 0; // Living neighbors
  var neighborsList = new List<Cell>(); // List of neighbors
  int coordX = 0;
  int coordY = 0;

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
    // if (this.neighbors > 0) {
    //   print('${this.getName()}: ${this.neighbors}');
    // }
  }

  /// Get the new status of the cell (alive or dead).
  /// A 'tick' is one life-cycle.
  int tick() {
    if (this.state == 1) {
      if (this.neighbors < 2) {
        return 0;
      }
      if (this.neighbors == 2 || this.neighbors == 3) {
        return 1;
      }
      if (this.neighbors > 3) {
        return 0;
      }
    } else {
      if (this.neighbors == 3) {
        return 1;
      } else {
        return 0;
      }
    }
    return 0;
  }
}