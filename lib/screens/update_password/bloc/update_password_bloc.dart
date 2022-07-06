import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/user_repository.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc
    extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  final UserRepository _repository;
  UpdatePasswordBloc({required UserRepository repository})
      : _repository = repository,
        super(const UpdatePasswordState()) {
    on<SavePressed>(_onSavePressed);
  }

  FutureOr<void> _onSavePressed(SavePressed event, emit) async {
    emit(const UpdatePasswordState(status: UpdatePasswordStatus.loading));
    try {
      final success = await _repository.changePassword(
        event.newPassword,
        event.currentPassword,
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
