import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/user_repository.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  final UserRepository _repository;
  VerifyEmailCubit({required UserRepository repository})
      : _repository = repository,
        super(VerifyEmailInitial());

  Future<void> sendVerificationEmail() async {
    emit(const ResendLoading());
    try {
      await _repository.sendVerificationEmail();
      emit(const ResendSuccess());
    } on Exception catch (err) {
      emit(ResendError(message: (err as dynamic).message));
    }
  }
}
