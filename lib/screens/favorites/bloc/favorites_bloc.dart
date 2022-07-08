import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rentall/data/models/models.dart';

import '../../../data/repository/rental_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavouritesBloc extends Bloc<FavoritesEvent, FavouritesState> {
  final RentalRepository _repository;
  FavouritesBloc({required RentalRepository repository})
      : _repository = repository,
        super(const FavouritesState()) {
    on<LoadFavorites>(_LoadFavourites);
  }
  FutureOr<void> _LoadFavourites(LoadFavorites event, emit) async {
    emit(const FavouritesState(status: FavouritesStatus.loading));
    try {
      final favourits = await _repository.getFavourites();
      emit(FavouritesState(
          status: FavouritesStatus.success, favourites: favourits));
    } on Exception catch (err) {
      emit(
        FavouritesState(
          status: FavouritesStatus.failed,
          message: (err as dynamic).message,
        ),
      );
    }
  }
}
