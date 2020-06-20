import 'package:multitables/models/test_group.dart';

const PRACTICE_TEST_GROUPS = const [
//  TestGroup(
//    id: 'practice-0',
//    title: 'Number 0',
//    description: 'Multiply number 0',
//    problemsClass: [0],
//    iconImage: '',
//    itemsCount: 10,
//    isTimed: false,
//  ),
  TestGroup(
    id: 'test-practice-1',
    title: 'Number 1',
    description: '',
    problemsClass: [2],
    iconImage: 'practice-numbers/one.png',
    itemsCount: 1,
    isTimed: false,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-1',
    title: 'Number 1',
    problemsClass: [1],
    iconImage: 'practice-numbers/one.png',
    itemsCount: 10,
    isTimed: false,
    coefficient: 1.0,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-2',
    title: 'Number 2',
    problemsClass: [2],
    iconImage: 'practice-numbers/two.png',
    itemsCount: 10,
    isTimed: false,
    coefficient: 1.0,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-3',
    title: 'Number 3',
    problemsClass: [3],
    iconImage: 'practice-numbers/three.png',
    itemsCount: 10,
    isTimed: false,
    coefficient: 1.0,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-123',
    title: 'Numbers 1 to 3',
    problemsClass: [1, 2, 3],
    iconImage: 'practice-numbers/one-three.png',
    itemsCount: 20,
    isTimed: false,
    coefficient: 1.1,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-4',
    title: 'Number 4',
    problemsClass: [4],
    iconImage: 'practice-numbers/four.png',
    itemsCount: 10,
    isTimed: false,
    coefficient: 1.1,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-5',
    title: 'Number 5',
    problemsClass: [5],
    iconImage: 'practice-numbers/five.png',
    itemsCount: 10,
    isTimed: false,
    coefficient: 1.1,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-2345',
    title: 'Numbers 2 to 5',
    problemsClass: [2, 3, 4, 5],
    iconImage: 'practice-numbers/two-five.png',
    itemsCount: 25,
    isTimed: false,
    coefficient: 1.2,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-6',
    title: 'Number 6',
    problemsClass: [6],
    iconImage: 'practice-numbers/six.png',
    itemsCount: 10,
    isTimed: false,
    coefficient: 1.2,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-7',
    title: 'Number 7',
    problemsClass: [7],
    iconImage: 'practice-numbers/seven.png',
    itemsCount: 10,
    isTimed: false,
    coefficient: 1.2,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-8',
    title: 'Number 8',
    problemsClass: [8],
    iconImage: 'practice-numbers/eight.png',
    itemsCount: 10,
    isTimed: false,
    coefficient: 1.3,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-9',
    title: 'Number 9',
    problemsClass: [9],
    iconImage: 'practice-numbers/nine.png',
    itemsCount: 10,
    isTimed: false,
    coefficient: 1.3,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-10',
    title: 'Number 10',
    problemsClass: [10],
    iconImage: 'practice-numbers/ten.png',
    itemsCount: 10,
    isTimed: false,
    coefficient: 1.3,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-12345678910',
    title: 'Numbers 1 to 10',
    problemsClass: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    iconImage: 'practice-numbers/one-ten.png',
    itemsCount: 30,
    isTimed: false,
    coefficient: 1.4,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-11',
    title: 'Number 11',
    problemsClass: [11],
    iconImage: 'practice-numbers/eleven.png',
    itemsCount: 11,
    isTimed: false,
    coefficient: 1.4,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-12',
    title: 'Number 12',
    problemsClass: [12],
    iconImage: 'practice-numbers/twelve.png',
    itemsCount: 12,
    isTimed: false,
    coefficient: 1.4,
    withVariants: true,
  ),
  TestGroup(
    id: 'practice-123456789101112',
    title: 'Numbers 1 to 12',
    problemsClass: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    iconImage: 'practice-numbers/one-twelve.png',
    itemsCount: 30,
    isTimed: false,
    coefficient: 1.4,
    withVariants: true,
  ),
];

const EXAM_TEST_GROUPS = [
//  TestGroup(
//    id: 'test-exam-0',
//    title: 'Exam 0',
//    description: 'Numbers 1 to 5',
//    problemsClass: [1, 2, 3, 4, 5],
//    iconImage: 'exam-icons/unicorn.png',
//    itemsCount: 1,
//    isTimed: true,
//    withVariants: false,
//    coefficient: 1.5,
//  ),
  TestGroup(
    id: 'test-exam-1',
    title: 'Exam 1',
    description: 'Numbers 1 to 5',
    problemsClass: [1, 2, 3, 4, 5],
//    iconImage: 'exam-icons/unicorn.png',
    iconImage: 'exam-icons/dolphin.png',
    itemsCount: 20,
    isTimed: true,
    withVariants: false,
    coefficient: 1.5,
  ),
  TestGroup(
    id: 'test-exam-2',
    title: 'Exam 2',
    description: 'Numbers 1 to 10',
    problemsClass: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    iconImage: 'exam-icons/crab.png',
    itemsCount: 20,
    isTimed: true,
    withVariants: false,
    coefficient: 1.6,
  ),
  TestGroup(
    id: 'test-exam-3',
    title: 'Exam 3',
    description: 'Numbers 1 to 10',
    problemsClass: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    iconImage: 'exam-icons/seahorse.png',
    itemsCount: 40,
    isTimed: true,
    withVariants: false,
    coefficient: 1.6,
  ),
  TestGroup(
    id: 'test-exam-4',
    title: 'Exam 4',
    description: 'Numbers 1 to 12',
    problemsClass: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    iconImage: 'exam-icons/shark.png',
    itemsCount: 50,
    isTimed: true,
    withVariants: false,
    coefficient: 1.7,
  ),
  TestGroup(
    id: 'test-exam-5',
    title: 'Exam 5',
    description: 'Numbers 1 to 12',
    problemsClass: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    iconImage: 'exam-icons/octopus.png',
    itemsCount: 100,
    isTimed: true,
    withVariants: false,
    coefficient: 1.7,
  ),
];
