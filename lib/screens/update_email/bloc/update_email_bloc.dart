import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/user_repository.dart';

part 'update_email_event.dart';
part 'update_email_state.dart';

class UpdateEmailBloc extends Bloc<UpdateEmailEvent, UpdateEmailState> {
  final UserRepository _repository;
  UpdateEmailBloc({required UserRepository repository})
      : _repository = repository,
        super(const UpdateEmailState()) {
    on<SavePressed>(_onSavePressed);
  }

  FutureOr<void> _onSavePressed(SavePressed event, emit) async {
    emit(const UpdateEmailState(status: UpdateEmailStatus.loading));
    try {
      final success = await _repository.changeEmailAddress(
        event.newEmail,
        event.currentPassword,
      );
      if (success) {
        emit(const UpdateEmailState(status: UpdateEmailStatus.success));
      } else {
        throw Exception('Request failed');
      }
    } on Exception catch (err) {
      emit(
        UpdateEmailState(
          status: UpdateEmailStatus.failed,
          message: (err as dynamic).message,
        ),
      );
    }
  }
}
