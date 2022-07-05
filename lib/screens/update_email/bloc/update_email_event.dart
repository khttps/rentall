part of 'update_email_bloc.dart';

abstract class UpdateEmailEvent extends Equatable {
  const UpdateEmailEvent();

  @override
  List<Object> get props => [];
}

class SavePressed extends UpdateEmailEvent {
  final String newEmail;
  final String currentPassword;

  const SavePressed({required this.newEmail, required this.currentPassword});

  @override
  List<Object> get props => [newEmail, currentPassword];
}
