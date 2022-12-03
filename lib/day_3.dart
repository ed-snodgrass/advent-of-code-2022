import 'dart:io';
import 'dart:async';

Future<List<String>> parseInput() async {
  final file = File('inputs/day_3_puzzle.txt');
  return file.readAsLines();
}

List<String> findCommonCharacters(str1, str2) {
  List<String> commonCharacters = [];
  for (int i = 0; i < str1.length; i++) {
    if (str2.contains(str1[i])) {
      commonCharacters.add(str1[i]);
    }
  }
  return commonCharacters;
}

int findCharacterPriority(character) {
  if (character.codeUnitAt(0) >= 97) {
    return character.codeUnitAt(0) - 96;
  } else {
    return character.codeUnitAt(0) - 64 + 26;
  }
}

Future<void> puzzle1() async {
  try {
    var lines = await parseInput();
    int score = 0;
    for (var rucksackItems in lines) {
      int compartmentSize = (rucksackItems.length / 2).floor();
      String firstCompartment = rucksackItems.substring(0, compartmentSize);
      String secondCompartment = rucksackItems.substring(compartmentSize);

      var commonChar = findCommonCharacters(firstCompartment, secondCompartment)[0];
      score+= findCharacterPriority(commonChar);
    }
    print('Day3 Puzzle1: sum of item priorities: $score');

  } catch (e) {
    print('Error: $e');
  }
}

String findCommonCharacterOfThree(str1, str2, str3) {
  var commonCharacters = findCommonCharacters(str1, str2);
  var badge = findCommonCharacters(commonCharacters, str3);
  return badge[0];
}

Future<void> puzzle2() async {
  try {
    int score = 0;
    var lines = await parseInput();
    List<List<String>> elfGroups = [];
    int groupIndex = 0;
    while (groupIndex < lines.length) {
      elfGroups.add([
        lines[groupIndex + 0],
        lines[groupIndex + 1],
        lines[groupIndex + 2]
      ]);
      groupIndex += 3;
    }
    for (var element in elfGroups) {
      var badge = findCommonCharacterOfThree(element[0], element[1], element[2]);
      score += findCharacterPriority(badge);
    }
    print('Day3 Puzzle2: badge priority: $score');
    return;
  } catch (e) {
    print('Error: $e');
  }
}
