import 'package:multitables/models/problem.dart';
import 'package:multitables/models/test_group.dart';

class TestResults {
  final TestGroup testGroup;
  final List<Problem> testData;
  final int xp;
  final bool exam;

  const TestResults({
    this.testGroup,
    this.testData,
    this.xp,
    this.exam,
  });
}
