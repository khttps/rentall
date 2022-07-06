import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rentall/data/repository/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _repository;

  HomeBloc({required UserRepository repository})
      : _repository = repository,
        super(HomeInitial()) {
    on<LoadUser>(_onLoadUser);
  }

  FutureOr<void> _onLoadUser(event, emit) async {
    try {
      final user = await _repository.getUser();
      if (user == null) {
        emit(NoUser());
      }
      if (user!.hostName != null) {
        emit(UserWithHost());
      } else {
        emit(UserOnly());
      }
    } on Exception catch (err) {
      emit(Unknown(message: (err as dynamic).message));
    }
  }
}
