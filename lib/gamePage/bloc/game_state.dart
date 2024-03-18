part of 'game_bloc.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}

class RenderPages extends GameState {}

class WinDialog extends GameState {}