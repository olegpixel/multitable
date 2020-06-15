import 'package:multitables/models/problem.dart';
import 'dart:math';

const ANSWERS_COUNT = 4;

// Step 1: add response + answerCount - 1 into array
// Step 2: shuffle array
Problem generateAnswerVariants(int a, int b) {
  var random = new Random();
  int randInt = random.nextInt(100);
  List<int> answers = [];

  void checkUniquenessAndAdd(int toAdd) {
    if (toAdd <= 0) {
      return;
    }
    for (final i in answers) {
      if (i == toAdd) {
        return;
      }
    }
    answers.add(toAdd);
  }

  if (randInt < 65) {
    // question type - A x B = __
    answers.add(a * b);

    while (answers.length < ANSWERS_COUNT) {
      randInt = random.nextInt(100);
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
      questionString: '$a \u00D7 $b = ?',
      type: 1,
    );
  } else {
    // question type - A x __ = C
    answers.add(b);

    while (answers.length < ANSWERS_COUNT) {
      randInt = random.nextInt(100);
      if (randInt < 25) {
        checkUniquenessAndAdd(b + 1);
      } else if (randInt < 50) {
        checkUniquenessAndAdd(b - 1);
      } else if (randInt < 65) {
        checkUniquenessAndAdd(b + 2);
      } else if (randInt < 80) {
        checkUniquenessAndAdd(b - 2);
      } else if (randInt < 87) {
        checkUniquenessAndAdd(b + 3);
      } else if (randInt < 94) {
        checkUniquenessAndAdd(b - 3);
      } else if (randInt < 97) {
        checkUniquenessAndAdd(b - 4);
      } else if (randInt < 100) {
        checkUniquenessAndAdd(b + 4);
      }
    }

    answers.shuffle();

    return Problem(
      x: a,
      y: a * b,
      correctAnswer: b,
      answers: answers,
      questionString: '$a \u00D7 ? = ${a * b}',
      type: 2,
    );
  }
}

List<Problem> generateClosedTest(List<int> problemsClass, int itemsCount) {
  List<Problem> resp = [];
  int maxItem = problemsClass.reduce((curr, next) => curr > next ? curr : next);
  maxItem = maxItem > 10 ? maxItem : 10;
  List<int> oneToTen = [for (var i = 1; i <= maxItem; i += 1) i];

  for (final prClass in problemsClass) {
    for (final i in oneToTen) {
      resp.add(generateAnswerVariants(prClass, i));
    }
  }
  resp.shuffle();

  return resp.sublist(0, itemsCount <= resp.length ? itemsCount : resp.length);
}

List<Problem> generateOpenTest(List<int> problemsClass, int itemsCount) {
  List<Problem> resp = [];
  int maxItem = problemsClass.reduce((curr, next) => curr > next ? curr : next);
  maxItem = maxItem > 10 ? maxItem : 10;
  List<int> oneToTen = [for (var i = 1; i <= maxItem; i += 1) i];
  var random = new Random();

  for (final prClass in problemsClass) {
    for (final i in oneToTen) {
      int randInt = random.nextInt(100);
      if (randInt < 65) {
        resp.add(Problem(
          x: prClass,
          y: i,
          correctAnswer: prClass * i,
          questionString: '$prClass \u00D7 $i = ?',
          type: 1,
        ));
      } else {
        resp.add(Problem(
          x: prClass,
          y: prClass * i,
          correctAnswer: i,
          questionString: '$prClass \u00D7 ? = ${i * prClass}',
          type: 2,
        ));
      }
    }
  }
  resp.shuffle();

  return resp.sublist(0, itemsCount <= resp.length ? itemsCount : resp.length);
}
