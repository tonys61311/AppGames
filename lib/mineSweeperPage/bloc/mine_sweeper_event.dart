part of 'mine_sweeper_bloc.dart';

@immutable
abstract class MineSweeperEvent {}

class InitialGameData extends MineSweeperEvent {}

class ClickCube extends MineSweeperEvent {
  CubeModel data;
  ClickCube({this.data});
}

class LongPressCube extends MineSweeperEvent {
  CubeModel data;
  LongPressCube({this.data});
}