part of 'mine_sweeper_bloc.dart';

@immutable
abstract class MineSweeperState {}

class GameInitial extends MineSweeperState {}

class RenderPages extends MineSweeperState {}

class WinDialog extends MineSweeperState {}