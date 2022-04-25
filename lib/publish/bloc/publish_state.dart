part of 'publish_bloc.dart';

class PublishState extends Equatable {
  final LoadStatus status;
  final Rental? rental;
  final String? error;

  const PublishState({
    this.status = LoadStatus.loading,
    this.rental,
    this.error,
  });

  // PublishState copyWith({LoadStatus? status, Rental? rental, String? error}) =>
  //     PublishState(
  //       status: status ?? this.status,
  //       rental: rental ?? this.rental,
  //       error: error ?? this.error,
  //     );

  @override
  List<Object?> get props => [status, rental, error];
}
