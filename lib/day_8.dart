import 'dart:io';
import 'dart:async';

Future<List<String>> parseInput() async {
  final file = File('inputs/day_8_puzzle.txt');
  return file.readAsLines();
}

bool isVisible(List<String> lines, i, j) {
  var currentValue = int.parse(lines[i][j]);
  //check up
  for (int heightIndex = i - 1; heightIndex >= 0; heightIndex--) {
    if (heightIndex == 0 && int.parse(lines[heightIndex][j]) < currentValue) {
      return true;
    } else {
      if (int.parse(lines[heightIndex][j]) >= currentValue) {
        break;
      }
    }
  }
  //check down
  for (int heightIndex = i + 1; heightIndex < lines.length; heightIndex++) {
    if (heightIndex == lines.length - 1 && int.parse(lines[heightIndex][j]) < currentValue) {
      return true;
    } else {
      if (int.parse(lines[heightIndex][j]) >= currentValue) {
        break;
      }
    }
  }
  //check left
  for (int widthIndex = j - 1; widthIndex >= 0; widthIndex--) {
    if (widthIndex == 0 && int.parse(lines[i][widthIndex]) < currentValue) {
      return true;
    } else {
      if (int.parse(lines[i][widthIndex]) >= currentValue) {
        break;
      }
    }
  }
  //check right
  for (int widthIndex = j + 1; widthIndex < lines.length; widthIndex++) {
    if (widthIndex == lines.length - 1 && int.parse(lines[i][widthIndex]) < currentValue) {
      return true;
    } else {
      if (int.parse(lines[i][widthIndex]) >= currentValue) {
        break;
      }
    }
  }
  return false;
}

num findTreesVisibleFromOutsideGrid(List<String> lines) {
  num countOfVisibleTrees = (lines.length * 2) + ((lines[0].length - 2) * 2);
  for (int i = 1; i < lines.length - 1; i++) {
    var line = lines[i];
    for (int j = 1; j < line.length - 1; j++) {
      if (isVisible(lines, i, j)) {
        countOfVisibleTrees++;
      }
    }
  }
  return countOfVisibleTrees;
}

Future<num> puzzle1() async {
  var lines = await parseInput();
  var count = findTreesVisibleFromOutsideGrid(lines);
  print('Day 8 Puzzle 1: $count');
  return count;
}

num calculateScenicScore(List<String> lines, i, j) {
  var currentValue = int.parse(lines[i][j]);
  int up = 0;
  int down = 0;
  int left = 0;
  int right = 0;

  // check up
  for (int heightIndex = i - 1; heightIndex >= 0; heightIndex--) {
    if (int.parse(lines[heightIndex][j]) >= currentValue) {
      up++;
      break;
    } else {
      up++;
    }
  }
  //check down
  for (int heightIndex = i + 1; heightIndex < lines.length; heightIndex++) {
    if (int.parse(lines[heightIndex][j]) >= currentValue) {
      down++;
      break;
    } else {
      down++;
    }
  }
  //check left
  for (int widthIndex = j - 1; widthIndex >= 0; widthIndex--) {
    if (int.parse(lines[i][widthIndex]) >= currentValue) {
      left++;
      break;
    } else {
      left++;
    }
  }
  //check right
  for (int widthIndex = j + 1; widthIndex < lines.length; widthIndex++) {
    if (int.parse(lines[i][widthIndex]) >= currentValue) {
      right++;
      break;
    } else {
      right++;
    }
  }
  return up * down * left * right;
}


num findHighestScenicScore(List<String> lines) {
  num highestScenicScore = 0;
  for (int i = 1; i < lines.length - 1; i++) {
    var line = lines[i];
    for (int j = 1; j < line.length - 1; j++) {
      if (calculateScenicScore(lines, i, j) > highestScenicScore) {
        highestScenicScore = calculateScenicScore(lines, i, j);
      }
    }
  }
  return highestScenicScore;
}

Future<num> puzzle2() async {
  var lines = await parseInput();
  var highestScenicScore = findHighestScenicScore(lines);
  print('Day 8 Puzzle 2: $highestScenicScore');
  return highestScenicScore;
}

