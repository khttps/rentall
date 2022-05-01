part of 'publish_bloc.dart';

enum PublishLoadStatus { initial, loading, saving, published, failed }

class PublishState extends Equatable {
  final PublishLoadStatus status;
  final Rental? rental;
  final String? error;

  const PublishState({
    this.status = PublishLoadStatus.initial,
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
