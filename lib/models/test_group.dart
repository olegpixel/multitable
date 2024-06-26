import 'package:flutter/material.dart';

class TestGroup {
  final String id; // for set/get from Hive db
  final String title; // for FE
  final String description; // for FE
  final List<int> problemsClass; // e.g.  numbers 2,3,5
  final String iconImage;
  final bool isTimed; // enable/disable countdown for test
  final bool withVariants; // enable/disable countdown for test
  final int itemsCount; // how many problems in the test
  final double coefficient; // coefficient for XP

  const TestGroup(
      {@required this.id,
      @required this.title,
      this.description,
      @required this.problemsClass,
      @required this.iconImage,
      this.itemsCount = 10,
      this.isTimed = false,
      this.withVariants = true,
      this.coefficient = 1.0});
}
