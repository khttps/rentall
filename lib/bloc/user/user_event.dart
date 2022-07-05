part of 'user_bloc.dart';

abstract class AuthEvent extends Equatable {}

class Startup extends AuthEvent {
  @override
  List<Object?> get props => [];
}
