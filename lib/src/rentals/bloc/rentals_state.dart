part of 'rentals_bloc.dart';

enum LoadStatus { loading, loaded, error }

class RentalsState<T> extends Equatable {
  final LoadStatus status;
  final T? data;
  final String? error;

  const RentalsState({this.status = LoadStatus.loading, this.data, this.error});

  @override
  List<Object?> get props => [status, data, error];
}
