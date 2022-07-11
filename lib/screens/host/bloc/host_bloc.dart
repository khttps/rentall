import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/data/repository/user_repository.dart';

import '../../../data/models/models.dart';

part 'host_event.dart';
part 'host_state.dart';

class HostBloc extends Bloc<HostEvent, HostState> {
  final UserRepository _repository;
  HostBloc({required UserRepository repository})
      : _repository = repository,
        super(const HostState()) {
    on<SetupHost>(_onSetupHost);
    on<LoadHost>(_onLoadHost);
  }

  FutureOr<void> _onSetupHost(SetupHost event, emit) async {
    emit(state.copyWith(status: HostStatus.saving));
    try {
      await _repository.updateHost(event.host, event.image);
      emit(const HostState(status: HostStatus.saved));
    } on Exception catch (err) {
      emit(state.copyWith(
        status: HostStatus.error,
        message: (err as dynamic).message,
      ));
    }
  }

  FutureOr<void> _onLoadHost(LoadHost event, emit) async {
    try {
      final user = await _repository.getUser();
      emit(state.copyWith(status: HostStatus.loaded, user: user));
    } on Exception catch (err) {
      emit(state.copyWith(
        status: HostStatus.error,
        message: (err as dynamic).message,
      ));
    }
  }
}
