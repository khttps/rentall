part of 'verify_email_cubit.dart';

abstract class VerifyEmailState extends Equatable {
  const VerifyEmailState();

  @override
  List<Object> get props => [];
}

class VerifyEmailInitial extends VerifyEmailState {}

class ResendLoading extends VerifyEmailState {
  const ResendLoading();
  @override
  List<Object> get props => [];
}

class ResendSuccess extends VerifyEmailState {
  const ResendSuccess();
  @override
  List<Object> get props => [];
}

class ResendError extends VerifyEmailState {
  final String message;
  const ResendError({required this.message});

  @override
  List<Object> get props => [message];
}
