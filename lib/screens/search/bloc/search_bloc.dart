import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/rental_repository.dart';

import '../../../data/models/models.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final RentalRepository _repository;
  SearchBloc({required RentalRepository repository})
      : _repository = repository,
        super(const SearchState()) {
    on<SearchStarted>(_onSearchStarted);
  }

  FutureOr<void> _onSearchStarted(SearchStarted event, emit) async {
    emit(const SearchState(status: SearchStatus.loading));
    try {
      if (event.keyword.isEmpty) {
        emit(const SearchState());
      } else {
        final results = await _repository.getSearchResults(event.keyword);
        if (results.isEmpty) {
          emit(const SearchState());
        } else {
          emit(SearchState(status: SearchStatus.loaded, results: results));
        }
      }
    } on Exception catch (err) {
      emit(SearchState(
        status: SearchStatus.error,
        message: (err as dynamic).message,
      ));
    }
  }
}
