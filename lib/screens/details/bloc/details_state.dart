part of 'details_bloc.dart';

enum DetailsStatus { owned, unowned, loggedOut, error }

class DetailsState extends Equatable {
  final DetailsStatus status;
  final bool isFavorited;
  final String? message;
  const DetailsState({
    this.status = DetailsStatus.unowned,
    this.isFavorited = false,
    this.message,
  });

  DetailsState copyWith(
          {DetailsStatus? status, bool? isFavorited, String? message}) =>
      DetailsState(
        status: status ?? this.status,
        isFavorited: isFavorited ?? this.isFavorited,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [status, isFavorited, message];
}
