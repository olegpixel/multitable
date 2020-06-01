import 'package:flutter/material.dart';

class UserLevel {
  final int id; // unique identifier
  final String name; // e.g. Level 1
  final String icon; // image
  final int number; // questions answered

  const UserLevel(
      {@required this.id,
      @required this.name,
      @required this.icon,
      @required this.number});
}
