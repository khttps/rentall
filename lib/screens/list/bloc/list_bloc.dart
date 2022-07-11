import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/data/models/models.dart';

import '../../../data/repository/rental_repository.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final RentalRepository _repository;
  ListBloc({required RentalRepository repository})
      : _repository = repository,
        super(const ListState()) {
    on<LoadList>(_onLoadList);
  }
  FutureOr<void> _onLoadList(LoadList event, emit) async {
    emit(const ListState(status: FavouritesStatus.loading));
    try {
      final favourits = await _repository.getList(event.collection);
      emit(ListState(status: FavouritesStatus.success, favourites: favourits));
    } on Exception catch (err) {
      emit(
        ListState(
          status: FavouritesStatus.failed,
          message: (err as dynamic).message,
        ),
      );
    }
  }
}
