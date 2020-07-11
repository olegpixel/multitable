import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:multitables/datastore/test_groups.dart';
import 'package:multitables/datastore/user_levels.dart';
import 'package:multitables/models/user_level.dart';
import 'package:multitables/funcs/localisations.dart';

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
    String postfix = date.year.toString() + date.month.toString() + date.day.toString();
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

NextLevelPoints getPointsToNextLevel() {
  int curCount = getXP();
  UserLevel level;
  int ind = 0;
  int pointToLevel = 0;
  do {
    level = USER_LEVELS[ind];
    ind++;
  } while (level.number <= curCount && ind < USER_LEVELS.length);

  if (ind - 1 >= USER_LEVELS.length) {
    print("curCount");
    print(curCount);
    print(USER_LEVELS[ind - 2].number);
    print(curCount);
    NextLevelPoints resp = NextLevelPoints(
      current: curCount - USER_LEVELS[ind - 2].number,
      totalLevelPoints: 100,
    );
    return resp;
  } else {
    NextLevelPoints resp = NextLevelPoints(
      current: curCount - USER_LEVELS[ind - 2].number,
      totalLevelPoints: USER_LEVELS[ind - 1].number - USER_LEVELS[ind - 2].number,
    );
    return resp;
  }
}

// return User Level based on total questions solved
UserLevel getCurrentUserLevel() {
  int curCount = getXP();
  UserLevel level;
  int ind = 0;
  do {
    level = USER_LEVELS[ind];
    ind++;
  } while (level.number <= curCount && ind < USER_LEVELS.length);
  return USER_LEVELS[ind - 2];
}

void updateCountersAndXP(int right, int wrong, int xp) async {
  var now = new DateTime.now().toLocal();
  String postfix = now.year.toString() + now.month.toString() + now.day.toString();
  if (right > 0) {
    int current = progressBox.get(TOTAL_SOLVED_KEY, defaultValue: 0);
    progressBox.put(TOTAL_SOLVED_KEY, current + right);
    int todayRight = progressBox.get(DATED_SOLVED_PREFIX_KEY + postfix, defaultValue: 0);
    progressBox.put(DATED_SOLVED_PREFIX_KEY + postfix, todayRight + right);
    addXP(xp);
  }
  if (wrong > 0) {
    int todayWrong = progressBox.get(DATED_WRONG_PREFIX_KEY + postfix, defaultValue: 0);
    progressBox.put(DATED_WRONG_PREFIX_KEY + postfix, todayWrong + wrong);
  }
  // TODO: delete older than 1 month
}

// average progress of all test groups
// outdated
double getTotalProgress() {
  double totalProgress = 0.0;
  PRACTICE_TEST_GROUPS.forEach((element) {
    totalProgress += progressBox.get(element.id, defaultValue: 0.0);
  });
  EXAM_TEST_GROUPS.forEach((element) {
    totalProgress += progressBox.get(element.id, defaultValue: 0.0);
  });

  return (totalProgress / (PRACTICE_TEST_GROUPS.length + EXAM_TEST_GROUPS.length));
}

List<dynamic> getLastWeekProgress(BuildContext context) {
  List<dynamic> resp = [];
  for (var i = 0; i < 7; i++) {
    var date = new DateTime.now().subtract(new Duration(days: i)).toLocal();
    int weekday = date.weekday;
    String postfix = date.year.toString() + date.month.toString() + date.day.toString();
    int right = progressBox.get(DATED_SOLVED_PREFIX_KEY + postfix, defaultValue: 0);
    int wrong = progressBox.get(DATED_WRONG_PREFIX_KEY + postfix, defaultValue: 0);
    resp.add([weekdayNumberToString(weekday, context), wrong.toDouble(), right.toDouble()]);
  }
  resp = resp.reversed.toList();
  return resp;
}

String weekdayNumberToString(int weekday, BuildContext context) {
  switch (weekday) {
    case 1:
      return AppLocalizations.of(context).translate('week-days-monday');
    case 2:
      return AppLocalizations.of(context).translate('week-days-tuesday');
    case 3:
      return AppLocalizations.of(context).translate('week-days-wednesday');
    case 4:
      return AppLocalizations.of(context).translate('week-days-thursday');
    case 5:
      return AppLocalizations.of(context).translate('week-days-friday');
    case 6:
      return AppLocalizations.of(context).translate('week-days-saturday');
    case 7:
      return AppLocalizations.of(context).translate('week-days-sunday');
    default:
      return '';
  }
}
