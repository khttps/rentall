part of 'alert_bloc.dart';

abstract class AlertEvent extends Equatable {
  const AlertEvent();

  @override
  List<Object?> get props => [];
}

class AddAlert extends AlertEvent {
  final Map<String, dynamic> alertMap;
  final List<String> keywords;
  const AddAlert({
    required this.alertMap,
    required this.keywords,
  });

  @override
  List<Object?> get props => [alertMap];
}

class UpdateAlert extends AlertEvent {
  final String id;
  final Map<String, dynamic> alert;
  final List<String> keywords;

  const UpdateAlert({
    required this.id,
    required this.alert,
    required this.keywords,
  });

  @override
  List<Object?> get props => [id, alert];
}

class DeleteAlert extends AlertEvent {
  final String id;
  const DeleteAlert({required this.id});

  @override
  List<Object?> get props => [id];
}
