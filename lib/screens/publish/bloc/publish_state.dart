part of 'publish_bloc.dart';

enum PublishLoadStatus {
  initial,
  loading,
  phoneLoaded,
  archived,
  published,
  failed,
  unachived
}

class PublishState extends Equatable {
  final PublishLoadStatus status;
  final Rental? rental;
  final String? phoneNumber;
  final String? error;

  const PublishState({
    this.status = PublishLoadStatus.initial,
    this.rental,
    this.phoneNumber,
    this.error,
  });

  @override
  List<Object?> get props => [status, rental, phoneNumber, error];

  PublishState copyWith({
    PublishLoadStatus? status,
    Rental? rental,
    String? phoneNumber,
    String? error,
  }) =>
      PublishState(
        status: status ?? this.status,
        rental: rental ?? this.rental,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        error: error ?? this.error,
      );
}
