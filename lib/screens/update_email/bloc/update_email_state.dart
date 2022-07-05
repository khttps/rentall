part of 'update_email_bloc.dart';

enum UpdateEmailStatus { initial, loading, success, failed }

class UpdateEmailState extends Equatable {
  final UpdateEmailStatus status;
  final String? message;
  const UpdateEmailState({
    this.status = UpdateEmailStatus.initial,
    this.message,
  });

  @override
  List<Object> get props => [status];
}
