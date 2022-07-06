part of 'search_bloc.dart';

enum SearchStatus { empty, loading, loaded, error }

class SearchState extends Equatable {
  final SearchStatus status;
  final List<Rental>? results;
  final String? message;

  const SearchState({
    this.status = SearchStatus.empty,
    this.results,
    this.message,
  });

  @override
  List<Object?> get props => [status, results, message];
}
