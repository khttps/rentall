part of 'update_password_bloc.dart';

enum UpdatePasswordStatus { initial, loading, success, failed, requiresLogin }

class UpdatePasswordState extends Equatable {
  final UpdatePasswordStatus status;
  final String? message;
  const UpdatePasswordState({
    this.status = UpdatePasswordStatus.initial,
    this.message,
  });

  @override
  List<Object?> get props => [status, message];
}
