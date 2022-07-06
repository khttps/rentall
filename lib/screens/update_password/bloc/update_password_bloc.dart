import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/user_repository.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc
    extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  final UserRepository _repository;
  UpdatePasswordBloc({required UserRepository repository})
      : _repository = repository,
        super(const UpdatePasswordState()) {
    on<SavePasswordPressed>(_onSavePasswordPressed);
  }

  FutureOr<void> _onSavePasswordPressed(SavePasswordPressed event, emit) async {
    emit(const UpdatePasswordState(status: UpdatePasswordStatus.loading));
    try {
      final success = await _repository.changePassword(
        event.currentPassword,
        event.newPassword,
      );
      if (success) {
        emit(const UpdatePasswordState(status: UpdatePasswordStatus.success));
      } else {
        throw Exception('Request failed');
      }
    } on Exception catch (err) {
      emit(
        UpdatePasswordState(
          status: UpdatePasswordStatus.failed,
          message: (err as dynamic).message,
        ),
      );
    }
  }
}
