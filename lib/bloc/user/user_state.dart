part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {
  const UserInitial();

  @override
  List<Object?> get props => [];
}

class Authenticated extends UserState {
  final User user;
  const Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends UserState {
  const Unauthenticated();

  @override
  List<Object?> get props => [];
}
