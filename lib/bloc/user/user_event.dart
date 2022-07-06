part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserChanged extends UserEvent {
  final User? user;

  const UserChanged({this.user});
  @override
  List<Object?> get props => [user];
}

class UserSignOut extends UserEvent {
  const UserSignOut();

  @override
  List<Object?> get props => [];
}
