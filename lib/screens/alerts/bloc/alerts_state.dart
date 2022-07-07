part of 'alerts_bloc.dart';

enum AlertsStatus { loading, loaded, failed }

class AlertsState extends Equatable {
  final AlertsStatus status;
  final List<Alert>? alerts;
  final String? message;

  const AlertsState({
    this.status = AlertsStatus.loading,
    this.alerts,
    this.message,
  });

  @override
  List<Object?> get props => [status, alerts, message];
}
