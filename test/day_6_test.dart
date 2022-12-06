import 'package:advent_of_code_2022/day_6.dart';
import 'package:test/test.dart';

void main() {
  test('puzzle1', () async {
    expect(await puzzle1(), 1779);
  });
  test('puzzle2', () async {
    expect(await puzzle2(), 2635);
  });
}
