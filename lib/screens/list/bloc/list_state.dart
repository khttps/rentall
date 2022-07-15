part of 'list_bloc.dart';

enum ListStatus { initial, loading, success, failed }

class ListState extends Equatable {
  final ListStatus status;
  final List<Rental>? rentals;
  final String? message;

  const ListState({
    this.status = ListStatus.initial,
    this.rentals,
    this.message,
  });

  @override
  List<Object?> get props => [status, rentals, message];
}
