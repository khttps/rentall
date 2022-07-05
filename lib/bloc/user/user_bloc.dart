import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/data/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<AuthEvent, UserState> {
  final UserRepository _repository;

  UserBloc({required UserRepository repository})
      : _repository = repository,
        super(const UserInitial()) {
    on<Startup>((_onAppStarted));
  }

  _onAppStarted(Startup event, emit) {
    try {
      final isSignedIn = _repository.isSignedIn;
      if (isSignedIn) {
        final user = _repository.currentUser;
        emit(Authenticated(user: user!));
      } else {
        emit(const Unauthenticated());
      }
    } on Exception {
      emit(const Unauthenticated());
    }
  }
}
