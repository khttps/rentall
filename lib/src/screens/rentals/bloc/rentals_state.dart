part of 'rentals_bloc.dart';

abstract class RentalsState extends Equatable {
  const RentalsState();

  @override
  List<Object> get props => [];
}

class RentalsLoading extends RentalsState {}

class RentalsError extends RentalsState {
  final String message;
  const RentalsError(this.message);

  @override
  List<Object> get props => [message];
}

class RentalsLoaded extends RentalsState {
  final List<Rental> rentals;
  const RentalsLoaded(this.rentals);

  @override
  List<Object> get props => [rentals];
}
