import 'package:flutter/material.dart';
import 'dart:math';

dynamic getRandomElement(List<dynamic> arr) {
  var i = new Random().nextInt(arr.length);
  return arr[i];
}

const LANG =
  {

  'ENGLISH': {
    'test-results-great': [
      'Awesome!',
      'Excellent!',
      'Fantastic!',
      'Superb!',
      'Brilliant!',
      'Marvellous!',
      'Amazing!',
      'Fabulous!',
    ],
    'test-results-good': [
      'Good',
    ],
    'test-results-bad': ['Don\'t Give Up!']
  }
};
