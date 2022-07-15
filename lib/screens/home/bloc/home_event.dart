part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadUser extends HomeEvent {
  final User? user;

  const LoadUser({this.user});

  @override
  List<Object?> get props => [user];
}

class ReloadUser extends HomeEvent {
  const ReloadUser();

  @override
  List<Object?> get props => [];
}
