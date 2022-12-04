import 'dart:io';
import 'dart:async';

Future<List<String>> parseInput() async {
  final file = File('inputs/day_4_puzzle.txt');
  return file.readAsLines();
}

List<int> extrapolateRange(range) {
  List<int> extrapolatedRange = [];
  int beginning = int.parse(range[0]);
  int ending = int.parse(range[1]);
  if (beginning == ending) {
    extrapolatedRange.add(beginning);
    return extrapolatedRange;
  }
  for (int i = beginning; i <= ending; i++) {
    extrapolatedRange.add(i);
  }

  return extrapolatedRange;
}

bool fullyContains(List<int> range1, List<int> range2) {
  return range1.every((range1Value) => range2.contains(range1Value)) || range2.every((range2Value) => range1.contains(range2Value));
}

bool hasFullyContainedRange(elfPairSectionList) {
  var elfPair = elfPairSectionList.split(',');
  var firstElfRange = extrapolateRange(elfPair[0].split('-'));
  var secondElfRange = extrapolateRange(elfPair[1].split('-'));
  return fullyContains(firstElfRange, secondElfRange);
}

bool containsAny(List<int> range1, List<int> range2) {
  return range1.any((range1Value) => range2.contains(range1Value)) || range2.any((range2Value) => range1.contains(range2Value));
}

bool hasAnyOverlap(elfPairSectionList) {
  var elfPair = elfPairSectionList.split(',');
  var firstElfRange = extrapolateRange(elfPair[0].split('-'));
  var secondElfRange = extrapolateRange(elfPair[1].split('-'));
  return containsAny(firstElfRange, secondElfRange);
}

Future<void> puzzle1() async {
  try {
    var lines = await parseInput();
    int fullyContainedCount = lines.where(hasFullyContainedRange).length;
    print('Day4 Puzzle1 fully contained count: $fullyContainedCount');
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> puzzle2() async {
  try {
    var lines = await parseInput();
    int overlapCount = lines.where(hasAnyOverlap).length;
    print('Day4 Puzzle2 overlap count: $overlapCount');
  } catch (e) {
    print('Error: $e');
  }
}
