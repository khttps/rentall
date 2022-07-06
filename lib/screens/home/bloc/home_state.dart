part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class UserWithHost extends HomeState {}

class UserOnly extends HomeState {}

class NoUser extends HomeState {}

class Unknown extends HomeState {
  final String message;
  const Unknown({required this.message});

  @override
  List<Object> get props => [message];
}
