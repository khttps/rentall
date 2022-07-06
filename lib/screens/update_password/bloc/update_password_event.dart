part of 'update_password_bloc.dart';

abstract class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();

  @override
  List<Object> get props => [];
}

class SavePressed extends UpdatePasswordEvent {
  final String newPassword;
  final String currentPassword;

  const SavePressed({required this.newPassword, required this.currentPassword});

  @override
  List<Object> get props => [newPassword, currentPassword];
}
