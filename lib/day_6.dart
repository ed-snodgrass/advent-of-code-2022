import 'dart:io';
import 'dart:async';

Future<List<String>> parseInput() async {
  final file = File('inputs/day_6_puzzle.txt');
  return file.readAsLines();
}

int mineForSequence(List<String> inputData, int sequenceLength) {
  var lastFour = inputData.sublist(0, sequenceLength - 1);

  for (int i = sequenceLength - 1; i < inputData.length; i++) {
    if (lastFour.toSet().length == sequenceLength) {
      print(i);
      print('sequence: ${lastFour.toSet()}');
      return i;
    }
    int tempBeginning = i - (sequenceLength - 1);
    int tempEnd = tempBeginning + sequenceLength;
    var tempList = inputData.sublist(i - (sequenceLength - 1), tempEnd);

    lastFour = tempList;
    lastFour.add(inputData[i]);
  }
  return inputData.length;
}

Future<int> puzzle1() async {
  var lines = await parseInput();
  var dataStream = lines[0].split('');
  var answer = mineForSequence(dataStream, 4);
  print('Day 6 Puzzle 1: $answer');
  return answer;
}


Future<int> puzzle2() async {
  var lines = await parseInput();
  var dataStream = lines[0].split('');
  var answer = mineForSequence(dataStream, 14);
  print('Day 6 Puzzle 2: $answer');
  return answer;
}

