part of 'publish_bloc.dart';

enum PublishLoadStatus { initial, loading, deleted, published, failed }

class PublishState extends Equatable {
  final PublishLoadStatus status;
  final Rental? rental;
  final String? error;

  const PublishState({
    this.status = PublishLoadStatus.initial,
    this.rental,
    this.error,
  });

  @override
  List<Object?> get props => [status, rental, error];
}