part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchStarted extends SearchEvent {
  final String keyword;
  const SearchStarted({required this.keyword});

  @override
  List<Object> get props => [keyword];
}
