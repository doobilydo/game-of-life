import 'ui.dart' as ui;
import 'dart:html';
import 'Cell.dart';

// UI variables
var context = ui.getCanvas().getContext('2d');

var canvasWidth = ui.getCanvas().width;
var canvasHeight = ui.getCanvas().height;
var drawSquare = 7;
var drawWidth = drawSquare;
var drawHeight = drawSquare;
var border = 1;

Element stats = querySelector('#stats');

// Data variables
var cellSquare = 50;
var rows = cellSquare; // Y
var columns = cellSquare; // X
int lifeCycles = 5;
final sleepDuration = const Duration(milliseconds: 1000);

var livingCells = 0;
var lastCycle = 0;

var matrix = new List<Cell>();

var coordA = {0:1, 0.25:1, 0.5:0, 0.75:-1, 1:-1, 1.25:-1, 1.5:0, 1.75:1};
var coordB = {0:0, 0.25:-1, 0.5:-1, 0.75:-1, 1:0, 1.25:1, 1.5:1, 1.75:1};
