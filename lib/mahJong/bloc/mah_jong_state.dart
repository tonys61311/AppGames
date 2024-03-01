part of 'mah_jong_bloc.dart';

@immutable
abstract class MahJongState {}

class MahJongInitial extends MahJongState {}

class RenderPages extends MahJongState {}

class RestartState extends MahJongState{}

class ChangeFieldState extends MahJongState{
  String field;
  String val;
  ChangeFieldState({this.field, this.val});
}

class CheckAnswerState extends MahJongState{
  bool bingo;
  String winner;
  CheckAnswerState({this.bingo, this.winner});
}