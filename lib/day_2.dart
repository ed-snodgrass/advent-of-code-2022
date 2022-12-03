import 'dart:io';
import 'dart:async';

Future<List<String>> parseInput() async {
  final file = File('inputs/day_2_puzzle.txt');
  return file.readAsLines();
}

void puzzle1() async {
  try {
    var lines = await parseInput();
    var score = 0;

    for (var line in lines) {
      var choices = line.split(' ');
      if (choices[0] == 'A') {
        if (choices[1] == 'X') {
          score += 1;
          score += 3;
        } else if(choices[1] == 'Y') {
          score += 2;
          score += 6;
        } else if(choices[1] == 'Z') {
          score += 3;
          score += 0;
        }
      } else if (choices[0] == 'B') {
        if (choices[1] == 'X') {
          score += 1;
          score += 0;
        } else if(choices[1] == 'Y') {
          score += 2;
          score += 3;
        } else if(choices[1] == 'Z') {
          score += 3;
          score += 6;
        }
      } else if (choices[0] == 'C') {
        if (choices[1] == 'X') {
          score += 1;
          score += 6;
        } else if(choices[1] == 'Y') {
          score += 2;
          score += 0;
        } else if(choices[1] == 'Z') {
          score += 3;
          score += 3;
        }
      }
    }
    print(score);
  } catch (e) {
    print('Error: $e');
  }
}

void puzzle2() async {
  try {
    var lines = await parseInput();
    var score = 0;

    for (var line in lines) {
      var choices = line.split(' ');
      if (choices[0] == 'A') {
        if (choices[1] == 'X') {
          score += 3;
          score += 0;
        } else if(choices[1] == 'Y') {
          score += 1;
          score += 3;
        } else if(choices[1] == 'Z') {
          score += 2;
          score += 6;
        }
      } else if (choices[0] == 'B') {
        if (choices[1] == 'X') {
          score += 1;
          score += 0;
        } else if(choices[1] == 'Y') {
          score += 2;
          score += 3;
        } else if(choices[1] == 'Z') {
          score += 3;
          score += 6;
        }
      } else if (choices[0] == 'C') {
        if (choices[1] == 'X') {
          score += 0;
          score += 2;
        } else if(choices[1] == 'Y') {
          score += 3;
          score += 3;
        } else if(choices[1] == 'Z') {
          score += 1;
          score += 6;
        }
      }
    }
    print(score);
  } catch (e) {
    print('Error: $e');
  }
}
