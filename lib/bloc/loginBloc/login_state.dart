import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginLoadingState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginSuccessState extends LoginState {
  User user;
  LoginSuccessState({required this.user});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginFailedState extends LoginState {
  String message;
  LoginFailedState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
