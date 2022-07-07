import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/data/repository/alert_repository.dart';

import '../../../data/models/models.dart';

part 'alert_event.dart';
part 'alert_state.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  final AlertRepository _repository;
  AlertBloc({required AlertRepository repository})
      : _repository = repository,
        super(const AlertState()) {
    on<AddAlert>(_onAddAlert);
    on<UpdateAlert>(_onUpdateAlert);
    on<DeleteAlert>(_onDeleteAlert);
  }

  FutureOr<void> _onAddAlert(AddAlert event, emit) async {
    emit(const AlertState(status: AlertStatus.loading));
    try {
      await _repository.addAlert({
        ...event.alertMap,
        'keywords': event.keywords,
      });
      emit(const AlertState(status: AlertStatus.success));
    } on Exception catch (err) {
      emit(
        AlertState(
          status: AlertStatus.failed,
          error: (err as dynamic).message,
        ),
      );
    }
  }

  FutureOr<void> _onUpdateAlert(UpdateAlert event, emit) async {
    emit(const AlertState(status: AlertStatus.loading));
    try {
      await _repository.updateAlert(event.id, {
        ...event.alert,
        'keywords': event.keywords,
      });
      emit(const AlertState(status: AlertStatus.success));
    } on Exception catch (err) {
      emit(
        AlertState(
          status: AlertStatus.failed,
          error: (err as dynamic).message,
        ),
      );
    }
  }

  FutureOr<void> _onDeleteAlert(DeleteAlert event, emit) async {
    emit(const AlertState(status: AlertStatus.loading));
    try {
      await _repository.removeAlert(event.id);
      emit(const AlertState(status: AlertStatus.success));
    } on Exception catch (err) {
      emit(
        AlertState(
          status: AlertStatus.failed,
          error: (err as dynamic).message,
        ),
      );
    }
  }
}
