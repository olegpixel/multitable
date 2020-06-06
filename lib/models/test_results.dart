import 'package:multitables/models/problem.dart';
import 'package:multitables/models/test_group.dart';
import 'package:multitables/models/user_level.dart';

class TestResults {
  final TestGroup testGroup;
  final List<Problem> testData;
  final int xp;
  final bool exam;
  final bool nextLevelModal;
  final UserLevel level;

  const TestResults({
    this.testGroup,
    this.testData,
    this.xp,
    this.exam,
    this.nextLevelModal,
    this.level,
  });
}
