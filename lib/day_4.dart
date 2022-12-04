import 'dart:io';
import 'dart:async';

List<List<int>> getElfSectionRange(String lineInput) {
  var elfPair = lineInput.split(',');
  return [elfPair[0].split('-').map((e) => int.parse(e)).toList(), elfPair[1].split('-').map((e) => int.parse(e)).toList()];
}

Future<Iterable<List<List<int>>>> parseInput() async {
  final file = File('inputs/day_4_puzzle.txt');
  final lines = await file.readAsLines();
  return lines.map((line) => getElfSectionRange(line));
}

bool fullyContains(elfSectionList) {
  var range1 = elfSectionList[0];
  var range2 = elfSectionList[1];
  return ((range1[0] >= range2[0] && range1[1] <= range2[1]) || (range2[0] >= range1[0] && range2[1] <= range1[1]));
}

bool containsAny(elfSectionList) {
  var range1 = elfSectionList[0];
  var range2 = elfSectionList[1];
  return ((range1[0] >= range2[0] && range1[0] <= range2[1]) || (range2[0] >= range1[0] && range2[0] <= range1[1]));
}

Future<void> puzzle1() async {
  try {
    var elfSectionRange = await parseInput();
    int fullyContainedCount = elfSectionRange.where(fullyContains).length;
    print('Day4 Puzzle1 fully contained count2: $fullyContainedCount');
  } catch (e) {
    print('Error: $e');
  }
}

Future<void> puzzle2() async {
  try {
    var elfSectionRange = await parseInput();
    int overlapCount = elfSectionRange.where(containsAny).length;
    print('Day4 Puzzle2 overlap count: $overlapCount');
  } catch (e) {
    print('Error: $e');
  }
}
