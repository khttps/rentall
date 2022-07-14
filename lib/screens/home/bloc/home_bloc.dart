import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rentall/data/repository/user_repository.dart';

import '../../../data/models/models.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _repository;

  HomeBloc({required UserRepository repository})
      : _repository = repository,
        super(HomeInitial()) {
    _repository.watchUserFromCollection().listen((user) {
      add(LoadUser(user: user));
    });
    on<LoadUser>(_onLoadUser);
    on<ReloadUser>(_onReloadUser);
  }

  FutureOr<void> _onLoadUser(LoadUser event, emit) async {
    try {
      final user = event.user;
      if (user == null) {
        emit(NoUser());
      } else if (user.hostName != null) {
        emit(UserWithHost());
      } else if (!user.verified) {
        emit(UserOnlyEmailUnverified());
      } else {
        emit(UserOnly());
      }
    } on Exception catch (err) {
      emit(Unknown(message: (err as dynamic).message));
    }
  }

  FutureOr<void> _onReloadUser(ReloadUser event, emit) async {
    await _repository.reloadUser();
  }
}
