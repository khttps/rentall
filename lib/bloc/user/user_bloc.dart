import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/data/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;

  UserBloc({required UserRepository repository})
      : _repository = repository,
        super(const UserInitial()) {
    _repository.userChanges.listen((user) {
      add(UserChanged(user: user));
    });

    on<UserChanged>(_onUserChanged);
    on<UserSignOut>(_onUserSignOut);
  }

  _onUserChanged(UserChanged event, emit) {
    emit(const UserLoading());
    try {
      final user = event.user;
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(const Unauthenticated());
      }
    } on Exception {
      emit(const UserError());
    }
  }

  FutureOr<void> _onUserSignOut(UserSignOut event, emit) async {
    emit(const UserLoading());
    try {
      await _repository.signOut();
      emit(const UserLoggedOut());
    } on Exception {
      emit(const UserError());
    }
  }
}
