import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/repository/user_repository.dart';

import '../../../data/models/models.dart';

part 'owner_state.dart';

class OwnerCubit extends Cubit<OwnerState> {
  final UserRepository _repository;
  OwnerCubit({required UserRepository repository})
      : _repository = repository,
        super(OwnerInitial());

  Future<void> getOwner(String userId) async {
    emit(const OwnerLoading());
    try {
      final user = await _repository.getUserFromCollection(id: userId);
      if (user == null) {
        throw Exception('User not found');
      }
      emit(OwnerLoaded(owner: user));
    } on Exception catch (err) {
      emit(OwnerError(message: (err as dynamic).message));
    }
  }
}
