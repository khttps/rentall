part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitital extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class SignInSuccess extends AuthState {
  final User user;
  const SignInSuccess({required this.user});
  @override
  List<Object?> get props => [user];
}

class SignUpSuccess extends AuthState {
  final User user;
  const SignUpSuccess({required this.user});
  @override
  List<Object?> get props => [user];
}

class EmailSent extends AuthState {
  final String email;
  const EmailSent({required this.email});
  @override
  List<Object?> get props => [email];
}

class AuthFailed extends AuthState {
  final String message;
  const AuthFailed({required this.message});
  @override
  List<Object?> get props => [message];
}
