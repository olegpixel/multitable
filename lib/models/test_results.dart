import 'package:flutter/material.dart';
import 'package:multitables/models/problem.dart';

class TestResults {
  final String closePath;
  final String retryPath;
  final List<Problem> testData;

  const TestResults({
    this.closePath,
    this.retryPath,
    this.testData,
  });
}
