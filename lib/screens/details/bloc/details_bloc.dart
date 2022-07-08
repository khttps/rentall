import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/data/repository/rental_repository.dart';
import 'package:rentall/data/repository/user_repository.dart';

import '../../../data/models/models.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final UserRepository _userRepository;
  final RentalRepository _rentalRepository;
  DetailsBloc({
    required UserRepository userRepository,
    required RentalRepository rentalRepository,
  })  : _userRepository = userRepository,
        _rentalRepository = rentalRepository,
        super(const DetailsState()) {
    on<CheckCurrentUser>(_onCheckCurrentUser);
    on<SetFavorited>(_onSetFavorited);
    on<RemoveFavorited>(_onRemoveFavorite);
  }

  FutureOr<void> _onCheckCurrentUser(CheckCurrentUser event, emit) async {
    if (!_userRepository.isSignedIn) {
      emit(state.copyWith(status: DetailsStatus.loggedOut));
    } else {
      try {
        final isOwned = _userRepository.isOwned(event.rental.userId);
        if (isOwned) {
          emit(state.copyWith(status: DetailsStatus.owned));
        } else {
          final isFavorited =
              await _userRepository.isFavorited(event.rental.id!);
          emit(state.copyWith(
            isFavorited: isFavorited,
            status: DetailsStatus.unowned,
          ));
        }
      } on Exception catch (err) {
        emit(state.copyWith(
          message: (err as dynamic).message,
          status: DetailsStatus.error,
        ));
      }
    }
  }

  FutureOr<void> _onSetFavorited(SetFavorited event, emit) async {
    try {
      await _rentalRepository.setFavorited(event.rental);
      emit(state.copyWith(isFavorited: true));
    } on Exception catch (err) {
      emit(
        state.copyWith(message: (err as dynamic).message),
        status: DetailsStatus.error,
      );
    }
  }

  FutureOr<void> _onRemoveFavorite(RemoveFavorited event, emit) async {
    try {
      await _rentalRepository.removeFavorited(event.rental);
      emit(state.copyWith(isFavorited: false));
    } on Exception catch (err) {
      emit(
        state.copyWith(message: (err as dynamic).message),
        status: DetailsStatus.error,
      );
    }
  }
}
