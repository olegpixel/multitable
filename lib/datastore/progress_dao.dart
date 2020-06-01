import 'package:hive/hive.dart';
import 'package:multitables/datastore/test_groups.dart';
import 'package:multitables/datastore/user_levels.dart';
import 'package:multitables/models/user_level.dart';

const HIVE_PROGRESS_BOX = 'HIVE_PROGRESS_BOX';
const TOTAL_SOLVED_KEY = 'TOTAL_SOLVED_KEY';
const XP_NUMBER_KEY = 'XP_NUMBER_KEY';
const DATED_SOLVED_PREFIX_KEY = 'DATED_SOLVED_PREFIX_KEY';
const DATED_WRONG_PREFIX_KEY = 'DATED_WRONG_PREFIX_KEY';

var progressBox = Hive.box(HIVE_PROGRESS_BOX);

// progress of a specific test group
double getGroupProgress(String groupName) {
  return progressBox.get(groupName, defaultValue: 0.0);
}

void updateGroupProgress(String groupName, double newValue) {
  progressBox.put(groupName, newValue);
}

// how many problems have been solved in total
int getTotalCounter() {
  return progressBox.get(TOTAL_SOLVED_KEY, defaultValue: 0);
}

void clearTotalCounter() {
  progressBox.put(TOTAL_SOLVED_KEY, 0);
}

void clearAllStats() {
  progressBox.put(TOTAL_SOLVED_KEY, 0);
  progressBox.put(XP_NUMBER_KEY, 0);
  for (var i = 0; i < 7; i++) {
    var date = new DateTime.now().subtract(new Duration(days: i)).toLocal();
    String postfix =
        date.year.toString() + date.month.toString() + date.day.toString();
    progressBox.put(DATED_SOLVED_PREFIX_KEY + postfix, 0);
    progressBox.put(DATED_WRONG_PREFIX_KEY + postfix, 0);
  }
  PRACTICE_TEST_GROUPS.forEach((element) {
    progressBox.put(element.id, 0.0);
  });
  EXAM_TEST_GROUPS.forEach((element) {
    progressBox.put(element.id, 0.0);
  });
}

int getXP() {
  return progressBox.get(XP_NUMBER_KEY, defaultValue: 0);
}

void addXP(int add) {
  int c = progressBox.get(XP_NUMBER_KEY, defaultValue: 0);
  progressBox.put(XP_NUMBER_KEY, c + add);
}

// return User Level based on total questions solved
UserLevel getCurrentUserLevel() {
  int curCount = getXP();
  UserLevel level;
  int ind = 0;
  do {
    level = USER_LEVELS[ind];
    ind++;
  } while (level.number <= curCount);
  return USER_LEVELS[ind - 2];
}

void updateCountersAndXP(int rght, int wrng, int xpToAdd) async {
  var now = new DateTime.now().toLocal();
  String postfix =
      now.year.toString() + now.month.toString() + now.day.toString();
  if (rght > 0) {
    int current = progressBox.get(TOTAL_SOLVED_KEY);
    progressBox.put(TOTAL_SOLVED_KEY, current + rght);
    int todayCurrent =
        progressBox.get(DATED_SOLVED_PREFIX_KEY + postfix, defaultValue: 0);
    progressBox.put(DATED_SOLVED_PREFIX_KEY + postfix, todayCurrent + rght);
    // add XP
    addXP(xpToAdd);
  }
  if (wrng > 0) {
    int todayWrongCurrent =
        progressBox.get(DATED_WRONG_PREFIX_KEY + postfix, defaultValue: 0);
    progressBox.put(DATED_WRONG_PREFIX_KEY + postfix, todayWrongCurrent + wrng);
  }
  // TODO: delete older than 1 month
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
