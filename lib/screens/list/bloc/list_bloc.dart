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
    emit(const ListState(status: ListStatus.loading));
    try {
      final rentals = await _repository.getList(
        collection: event.collection,
        userId: event.userId,
      );
      emit(ListState(status: ListStatus.success, rentals: rentals));
    } on Exception catch (err) {
      emit(
        ListState(
          status: ListStatus.failed,
          message: (err as dynamic).message,
        ),
      );
    }
  }
}
