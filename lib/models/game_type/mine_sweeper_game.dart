import 'package:flutter/material.dart';
import 'package:games/mineSweeperPage/mineSweeperPage.dart';
import 'game_type.dart';

class MineSweeperGame extends GameType {
  @override
  String get title => 'MineSweeper';

  @override
  String get imagePath => 'assets/img/gameIcon/bomb.png';

  @override
  // TODO: implement buildPage
  Widget get buildPage => MineSweeperPage();
}