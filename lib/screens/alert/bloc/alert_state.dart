part of 'alert_bloc.dart';

enum AlertStatus { initial, loading, deleted, success, failed }

class AlertState extends Equatable {
  final AlertStatus status;
  // final Alert? alert;
  final String? error;

  const AlertState({
    this.status = AlertStatus.initial,
    // this.alert,
    this.error,
  });

  @override
  List<Object?> get props => [status, error];
}
