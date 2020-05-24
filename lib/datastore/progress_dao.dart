import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'constants.dart';

class TestGroupDao {
  Future updateProgress(String groupName, double newValue) async {
    var progressBox = Hive.box(hiveProgressBox);
    return progressBox.put(groupName, newValue);
  }

  Future getProgress(String groupName) async {
    var progressBox = Hive.box(hiveProgressBox);
    return progressBox.get(groupName, defaultValue: 0);
  }
}
