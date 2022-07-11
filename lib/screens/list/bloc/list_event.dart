part of 'list_bloc.dart';

abstract class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

class LoadList extends ListEvent {
  final String collection;
  const LoadList({required this.collection});

  @override
  List<Object> get props => [collection];
}
