part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class InitialGameData extends GameEvent {}

class ClickCube extends GameEvent {
  CubeModel data;
  ClickCube({this.data});
}

class LongPressCube extends GameEvent {
  CubeModel data;
  LongPressCube({this.data});
}