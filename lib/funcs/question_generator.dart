import 'package:flutter/material.dart';
import 'package:multitables/datastore/constants.dart';
import 'package:multitables/models/problem.dart';
import 'dart:math';

// Step 1: add response + answerCount-1 into array
// Step 2: shuffle array
Problem generateAnswerVariants(int a, int b) {
  int res = a * b;
  var random = new Random();
  List<int> answers = [a * b];

  void checkUniquenessAndAdd(int toAdd) {
    if (toAdd < 0) {
      return;
    }
    for (final i in answers) {
      if (i == toAdd) {
        return;
      }
    }
    answers.add(toAdd);
  }

  while (answers.length < ANSWERS_COUNT) {
    int randInt = random.nextInt(100);
    if (randInt < 10) {
      checkUniquenessAndAdd((a + 1) * b);
    } else if (randInt < 20) {
      checkUniquenessAndAdd((b + 1) * a);
    } else if (randInt < 30) {
      checkUniquenessAndAdd((a - 1) * b);
    } else if (randInt < 40) {
      checkUniquenessAndAdd((b - 1) * a);
    } else if (randInt < 46) {
      checkUniquenessAndAdd((a + 2) * b);
    } else if (randInt < 52) {
      checkUniquenessAndAdd((b + 2) * a);
    } else if (randInt < 58) {
      checkUniquenessAndAdd((a - 2) * b);
    } else if (randInt < 64) {
      checkUniquenessAndAdd((b - 2) * a);
    } else if (randInt < 70) {
      checkUniquenessAndAdd(a * b + 10);
    } else if (randInt < 76) {
      checkUniquenessAndAdd(a * b - 10);
    } else if (randInt < 82) {
      checkUniquenessAndAdd(a * b + 1);
    } else if (randInt < 88) {
      checkUniquenessAndAdd(a * b - 1);
    } else if (randInt < 94) {
      checkUniquenessAndAdd(a * b + 2);
    } else if (randInt < 100) {
      checkUniquenessAndAdd(a * b - 2);
    }
  }

  answers.shuffle();

  return Problem(
    x: a,
    y: b,
    correctAnswer: a * b,
    answers: answers,
    questionString: '$a x $b = ?',
  );
}

List<Problem> generateClosedTest(List<int> problemsClass, int itemsCount) {
  List<Problem> resp = [];
  List<int> oneToTen = [for (var i = 1; i <= 10; i += 1) i];

  for (final prClass in problemsClass) {
    for (final i in oneToTen) {
      resp.add(generateAnswerVariants(prClass, i));
    }
  }
  resp.shuffle();

  return resp.sublist(0, itemsCount <= resp.length ? itemsCount : resp.length);
}
