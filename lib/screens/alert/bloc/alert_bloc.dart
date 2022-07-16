import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/data/repository/alert_repository.dart';
import 'package:workmanager/workmanager.dart';

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
      final id = await _repository.addAlert(
        Alert.fromJson({
          ...event.alertMap,
          'keywords': event.keywords,
        }),
      );
      // await Workmanager().registerPeriodicTask(
      //   'alert-task',
      //   'alertTask',
      //   tag: id,
      //   inputData: {
      //     'id': id,
      //   },
      //   frequency: const Duration(seconds: 10),
      // );
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
      await _repository.updateAlert(
        event.id,
        Alert.fromJson({
          ...event.alert,
          'keywords': event.keywords,
        }),
      );
      // await Workmanager().cancelByTag(event.id);
      // await Workmanager().registerPeriodicTask(
      //   'alert-task',
      //   'alertTask',
      //   tag: event.id,
      //   inputData: {
      //     'id': event.id,
      //   },
      //   frequency: const Duration(seconds: 10),
      // );
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
      // await Workmanager().cancelByTag(event.id);
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
