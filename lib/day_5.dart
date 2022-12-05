import 'dart:io';
import 'dart:async';

Future<List<String>> parseInput() async {
  final file = File('inputs/day_5_puzzle.txt');
  return file.readAsLines();
}

int findEndOfStackDescription(lines) {
  var linesUntilRearrangementProcedure = 0;
  var foundStackArrangement = false;
  while (linesUntilRearrangementProcedure < (lines.length - 1) && !foundStackArrangement) {
    if (lines[linesUntilRearrangementProcedure] == '') {
      foundStackArrangement = true;
    } else {
      linesUntilRearrangementProcedure++;
    }
  }
  return linesUntilRearrangementProcedure;
}

Map findStackState(inputBreak, lines) {
  var initialCrateStackState = {};
  var stackIndexes = {};
  var indexLine = lines[inputBreak - 1];
  for (int i = 0; i < indexLine.length; i++) {
    if (indexLine[i] != ' ') {
      stackIndexes.putIfAbsent(indexLine[i], () => i);
    }
  }

  for (int inputIndex = inputBreak - 2; inputIndex >= 0; inputIndex--) {
    var stackLine = lines[inputIndex];
    for (int j = 0; j < stackIndexes.length; j++) {
      var letterIndex = stackIndexes.values.elementAt(j);
      if (letterIndex < stackLine.length && stackLine[letterIndex].trim() != '') {
        if (initialCrateStackState[j + 1] == null) {
          initialCrateStackState.putIfAbsent(j + 1, () => [stackLine[letterIndex]]);
        } else {
          initialCrateStackState[j + 1].add(stackLine[letterIndex]);
        }
      }
    }
  }
  return initialCrateStackState;
}

Map performMove(howMany, origination, destination, stacks) {
  var originatingStack = stacks[origination];
  var destinationStack = stacks[destination];
  var initialOriginatingLength = originatingStack.length;

  for (int i = 0; i < howMany; i++) {
    var toMove = originatingStack[initialOriginatingLength - (1+i)];
    destinationStack.add(toMove);
    originatingStack.removeAt(initialOriginatingLength - (1+i));
  }
  return {...stacks, origination: originatingStack, destination: destinationStack};
}

Map performMoves(moveStartIndex, inputData, initialStackState) {
  for (int i = 0; i < inputData.length - moveStartIndex; i++) {
    var values = inputData[i + moveStartIndex].split(' ');
    initialStackState = performMove(int.parse(values[1]), int.parse(values[3]), int.parse(values[5]), initialStackState);
  }
  return initialStackState;
}

Map performMove_9001(howMany, origination, destination, stacks) {
  var originatingStack = stacks[origination];
  var destinationStack = stacks[destination];
  var initialOriginatingLength = originatingStack.length;

  for (int i = 0; i < howMany; i++) {
    var toMove = originatingStack[initialOriginatingLength - howMany];
    destinationStack.add(toMove);
    originatingStack.removeAt(initialOriginatingLength - howMany);
  }
  return {...stacks, origination: originatingStack, destination: destinationStack};
}

Map performMoves_9001(moveStartIndex, inputData, initialStackState) {
  for (int i = 0; i < inputData.length - moveStartIndex; i++) {
    var values = inputData[i + moveStartIndex].split(' ');
    initialStackState = performMove_9001(int.parse(values[1]), int.parse(values[3]), int.parse(values[5]), initialStackState);
  }
  return initialStackState;
}

Future<void> puzzle1() async {
  var lines = await parseInput();
  int endOfStackDescription = findEndOfStackDescription(lines);
  var initialCrateStackState = findStackState(endOfStackDescription, lines);

  var stackAfterMoves = performMoves(endOfStackDescription + 1, lines, initialCrateStackState);
  var topOfStack = stackAfterMoves.values.map((value) => value[value.length - 1]);
  print('Day5 Puzzle1 topOfStack: $topOfStack');
}

Future<void> puzzle2() async {
  var lines = await parseInput();
  int endOfStackDescription = findEndOfStackDescription(lines);
  var initialCrateStackState = findStackState(endOfStackDescription, lines);

  var stackAfterMoves = performMoves_9001(endOfStackDescription + 1, lines, initialCrateStackState);
  var topOfStack = stackAfterMoves.values.map((value) => value[value.length - 1]);
  print('Day5 Puzzle2 topOfStack: $topOfStack');
}
