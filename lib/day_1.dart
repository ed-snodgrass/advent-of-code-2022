import 'dart:io';
import 'dart:async';

Future<List<String>> parseInput() async {
  final file = File('inputs/day_1_puzzle.txt');
  return file.readAsLines();
}

List<int> groupElvesByCalories(List<String> input) {
  var elves = <int>[];
  int currentElf = 0;
  elves.add(0);
  for (var line in input) {
    if (line.isEmpty) {
      currentElf++;
      elves.add(0);
    } else {
      elves[currentElf] += int.parse(line);
    }
  }
  return elves;
}

void puzzle1() async {
  try {
    var lines = await parseInput();
    var elves = groupElvesByCalories(lines);
    elves.sort((a, b) => b.compareTo(a));
    print('Elf with the most calories: ${elves[0]}');
  } catch (e) {
    print('Error: $e');
  }
}


void puzzle2() async {
  try {
    var lines = await parseInput();
    var elves = groupElvesByCalories(lines);
    elves.sort((a, b) => b.compareTo(a));
    print('Total of top 3 elves: ${elves[0] + elves[1] + elves[2]}');
  } catch (e) {
    print('Error: $e');
  }
}
