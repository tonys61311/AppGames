import 'package:flutter/material.dart';

abstract class GameType {
  String get title;
  String get imagePath;
  Widget get buildPage;
}