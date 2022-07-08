part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class CheckCurrentUser extends DetailsEvent {
  final Rental rental;
  const CheckCurrentUser({required this.rental});

  @override
  List<Object> get props => [rental];
}

class SetFavorited extends DetailsEvent {
  final Rental rental;
  const SetFavorited({required this.rental});

  @override
  List<Object> get props => [rental];
}

class RemoveFavorited extends DetailsEvent {
  final Rental rental;
  const RemoveFavorited({required this.rental});

  @override
  List<Object> get props => [rental];
}
