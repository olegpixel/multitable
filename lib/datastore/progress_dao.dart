import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multitables/datastore/test_groups.dart';

const HIVE_PROGRESS_BOX = 'HIVE_PROGRESS_BOX';
const TOTAL_SOLVED_KEY = 'TOTAL_SOLVED_KEY';
const DATED_SOLVED_PREFIX_KEY = 'DATED_SOLVED_PREFIX_KEY';
const DATED_WRONG_PREFIX_KEY = 'DATED_WRONG_PREFIX_KEY';

var progressBox = Hive.box(HIVE_PROGRESS_BOX);

// progress of a specific test group
double getProgress(String groupName) {
  return progressBox.get(groupName, defaultValue: 0.0);
}

void updateProgress(String groupName, double newValue) {
  progressBox.put(groupName, newValue);
}

// how many problems have been solved in total
int getTotalCounter(String groupName) {
  return progressBox.get(groupName, defaultValue: 0);
}

void updateSolvedCounters(int rght, int wrng) async {
  progressBox.put(TOTAL_SOLVED_KEY, rght);
  var now = new DateTime.now().toLocal();
  String postfix =
      now.year.toString() + now.month.toString() + now.day.toString();
  if (rght > 0) {
    int current = progressBox.get(TOTAL_SOLVED_KEY);
    progressBox.put(TOTAL_SOLVED_KEY, current + rght);
    int todayCurrent =
        progressBox.get(DATED_SOLVED_PREFIX_KEY + postfix, defaultValue: 0);
    progressBox.put(DATED_SOLVED_PREFIX_KEY + postfix, todayCurrent + rght);
  }
  if (wrng > 0) {
    int todayWrongCurrent =
        progressBox.get(DATED_WRONG_PREFIX_KEY + postfix, defaultValue: 0);
    progressBox.put(DATED_WRONG_PREFIX_KEY + postfix, todayWrongCurrent + wrng);
    // TODO: delete older than 1 month
  }
}

// average progress of all test groups
double getTotalProgress() {
  double totalProgress = 0.0;
  PRACTICE_TEST_GROUPS.forEach((element) {
    totalProgress += progressBox.get(element.id, defaultValue: 0.0);
  });
  EXAM_TEST_GROUPS.forEach((element) {
    totalProgress += progressBox.get(element.id, defaultValue: 0.0);
  });

  print(totalProgress);
  print(PRACTICE_TEST_GROUPS.length + EXAM_TEST_GROUPS.length);

  return (totalProgress /
      (PRACTICE_TEST_GROUPS.length + EXAM_TEST_GROUPS.length));
}

List<dynamic> getLastWeekProgress() {
  List<dynamic> resp = [];
  for (var i = 0; i < 7; i++) {
    var date = new DateTime.now().subtract(new Duration(days: i)).toLocal();
    int weekday = date.weekday;
    String postfix =
        date.year.toString() + date.month.toString() + date.day.toString();
    int right =
        progressBox.get(DATED_SOLVED_PREFIX_KEY + postfix, defaultValue: 0);
    int wrong =
        progressBox.get(DATED_WRONG_PREFIX_KEY + postfix, defaultValue: 0);
    resp.add(
        [weekdayNumberToString(weekday), wrong.toDouble(), right.toDouble()]);
  }
  resp = resp.reversed.toList();
  print(resp);
  return resp;
}

String weekdayNumberToString(int weekday) {
  switch (weekday) {
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thu';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    case 7:
      return 'Sun';
    default:
      return '';
  }
}
