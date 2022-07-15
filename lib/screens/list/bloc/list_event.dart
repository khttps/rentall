part of 'list_bloc.dart';

abstract class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object?> get props => [];
}

class LoadList extends ListEvent {
  final String collection;
  final String? userId;
  const LoadList({required this.collection, this.userId});

  @override
  List<Object?> get props => [collection, userId];
}
