import 'package:advent_of_code_2022/day_8.dart';
import 'package:test/test.dart';

void main() {

  List<String> lines = ['30373', '25512', '65332', '33549', '35390'];
  group('day 8', () {
    group('puzzle 1', () {
      test('isVisible', () {
        expect(isVisible(lines, 1, 1), true);
        expect(isVisible(lines, 1, 3), false);
      });
      test('findTreesVisibleFromOutsideGrid', () {
        expect(findTreesVisibleFromOutsideGrid(lines), 21);
      });
      test('puzzle2', () {
        expect(puzzle1(), 1803);
      });
    });
    group('puzzle 2', () {
      test('calculateScenicScore', () {
        expect(calculateScenicScore(lines, 1, 2), 4);
        expect(calculateScenicScore(lines, 3, 2), 8);
      });
      test('findHighestScenicScore', () {
        expect(findHighestScenicScore(lines), 8);
      });
      test('puzzle2', () {
        expect(puzzle2(), 268912);
      });
    });
  });
}

/*
*
30373
25512
65332
33549
35390
Each tree is represented as a single digit whose value is its height, where 0 is the shortest and 9 is the tallest.

A tree is visible if all of the other trees between it and an edge of the grid are shorter than it. Only consider trees in the same row or column; that is, only look up, down, left, or right from any given tree.

All of the trees around the edge of the grid are visible - since they are already on the edge, there are no trees to block the view. In this example, that only leaves the interior nine trees to consider:

The top-left 5 is visible from the left and top. (It isn't visible from the right or bottom since other trees of height 5 are in the way.)
The top-middle 5 is visible from the top and right.
The top-right 1 is not visible from any direction; for it to be visible, there would need to only be trees of height 0 between it and an edge.
The left-middle 5 is visible, but only from the right.
The center 3 is not visible from any direction; for it to be visible, there would need to be only trees of at most height 2 between it and an edge.
The right-middle 3 is visible from the right.
In the bottom row, the middle 5 is visible, but the 3 and 4 are not.
With 16 trees visible on the edge and another 5 visible in the interior, a total of 21 trees are visible in this arrangement.
* */
