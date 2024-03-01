part of 'mah_jong_bloc.dart';

@immutable
abstract class MahJongEvent {}

class InitialMJData extends MahJongEvent {}

class GetKeyCards extends MahJongEvent {}

class RestartMJ extends MahJongEvent{}

class ChangeField extends MahJongEvent{
  String field;
  String val;
  ChangeField({this.field, this.val});
}

class DoRenderPages extends MahJongEvent{}

class CheckAnswer extends MahJongEvent{
  String role;
  CheckAnswer({this.role});
}
