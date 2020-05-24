import 'package:flutter/material.dart';

class TestGroup {
  int id; // automatically generated & unique

  final String title; // for FE
  final String description; // for FE
  final String groupClass; // e.g. exam / practice
  final int order; // for sorting
  final List<String> problemsClass; // e.g.  numbers 2,3,5
  final double progress;
  final int itemsCount; // how many problems in the test
  final bool isTimed; // enable/disable countdown for test

  TestGroup(
      {@required this.title,
      @required this.description,
      @required this.groupClass,
      @required this.order,
      @required this.problemsClass,
      @required this.progress,
      this.itemsCount = 10,
      this.isTimed = false});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'groupClass': groupClass,
      'order': order,
      'problemsClass': List<dynamic>.from(problemsClass.map((x) => x)),
      'progress': progress,
      'itemsCount': itemsCount,
      'isTimed': isTimed,
    };
  }

  static TestGroup fromJson(Map<String, dynamic> map) {
    return TestGroup(
      title: map['title'],
      description: map['description'],
      groupClass: map['groupClass'],
      order: map['order'],
      problemsClass: List<String>.from(map["problemsClass"].map((x) => x)),
      progress: map['progress'],
      itemsCount: map['itemsCount'],
      isTimed: map['isTimed'],
    );
  }
}
