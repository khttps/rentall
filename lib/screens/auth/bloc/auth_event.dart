part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInPressed extends AuthEvent {
  final String email;
  final String password;

  const SignInPressed({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpPressed extends AuthEvent {
  final String email;
  final String password;

  const SignUpPressed({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class ForgotPassword extends AuthEvent {
  final String email;

  const ForgotPassword({required this.email});

  @override
  List<Object?> get props => [email];
}

class SignInByGoogle extends AuthEvent {
  const SignInByGoogle();

  @override
  List<Object?> get props => [];
}

class SignInByFacebook extends AuthEvent {
  const SignInByFacebook();

  @override
  List<Object?> get props => [];
}
