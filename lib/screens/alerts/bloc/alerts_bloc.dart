import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/data/models/alert.dart';
import 'package:rentall/data/repository/alert_repository.dart';

part 'alerts_event.dart';
part 'alerts_state.dart';

class AlertsBloc extends Bloc<AlertsEvent, AlertsState> {
  final AlertRepository _repository;
  AlertsBloc({required AlertRepository repository})
      : _repository = repository,
        super(const AlertsState()) {
    on<LoadAlerts>(_onLoadAlerts);
  }

  FutureOr<void> _onLoadAlerts(LoadAlerts event, emit) async {
    emit(const AlertsState(status: AlertsStatus.loading));
    try {
      final alerts = await _repository.getAlerts();
      emit(AlertsState(status: AlertsStatus.loaded, alerts: alerts));
    } on Exception catch (err) {
      emit(AlertsState(
        status: AlertsStatus.failed,
        message: (err as dynamic).message,
      ));
    }
  }
}
