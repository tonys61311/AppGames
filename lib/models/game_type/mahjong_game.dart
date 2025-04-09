import 'package:flutter/material.dart';
import 'package:games/mahJong/mahJongPage.dart';
import 'game_type.dart';

class MahJongGame extends GameType {
  @override
  String get title => 'MahJong';

  @override
  String get imagePath => 'assets/img/gameIcon/mahjong.png';

  @override
  Widget get buildPage => MahJongPage(title: title);
}