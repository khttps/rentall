import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentall/data/models/models.dart';
import 'package:rentall/data/repository/user_repository.dart';

import '../../../data/repository/rental_repository.dart';

part 'publish_state.dart';
part 'publish_event.dart';

class PublishBloc extends Bloc<PublishEvent, PublishState> {
  final RentalRepository _repository;
  final UserRepository _userRepository;
  PublishBloc({
    required RentalRepository repository,
    required UserRepository userRepository,
  })  : _repository = repository,
        _userRepository = userRepository,
        super(const PublishState()) {
    on<PublishRental>(_onPublishRental);
    on<UpdateRental>(_onUpdateRental);
    on<ArchiveRental>(_onArchiveRental);
    on<DeleteRental>(_onDeleteRental);
    on<LoadPhoneNumber>(_onLoadPhoneNumber);
  }

  FutureOr<void> _onPublishRental(PublishRental event, emit) async {
    emit(state.copyWith(
      status: PublishLoadStatus.loading,
    ));
    try {
      final rental = await _repository.addRental(
        Rental.fromJson(event.rentalMap),
        event.images.map((img) => File(img.path)).toList(),
      );

      emit(state.copyWith(
        status: PublishLoadStatus.published,
        rental: rental,
      ));
    } on Exception catch (err) {
      emit(state.copyWith(
        status: PublishLoadStatus.failed,
        error: (err as dynamic).message,
      ));
    }
  }

  FutureOr<void> _onUpdateRental(UpdateRental event, emit) async {
    emit(state.copyWith(
      status: PublishLoadStatus.loading,
    ));
    try {
      final rental = await _repository.updateRental(
        event.id,
        Rental.fromJson(event.rental),
        event.images?.map((img) => File(img.path)).toList(),
      );

      emit(state.copyWith(
        status: PublishLoadStatus.published,
        rental: rental,
      ));
    } on Exception catch (err) {
      rethrow;
      emit(state.copyWith(
        status: PublishLoadStatus.failed,
        error: (err as dynamic).message,
      ));
    }
  }

  FutureOr<void> _onArchiveRental(ArchiveRental event, emit) async {
    emit(state.copyWith(
      status: PublishLoadStatus.loading,
    ));

    try {
      if (event.rental.publishStatus == PublishStatus.archived) {
        await _repository.unarchiveRental(event.rental.id!);
        emit(state.copyWith(status: PublishLoadStatus.unachived));
      } else {
        await _repository.archiveRental(event.rental.id!);
        emit(state.copyWith(status: PublishLoadStatus.archived));
      }
    } on Exception catch (err) {
      emit(state.copyWith(
        status: PublishLoadStatus.failed,
        error: (err as dynamic).message,
      ));
    }
  }

  FutureOr<void> _onDeleteRental(DeleteRental event, emit) async {
    emit(state.copyWith(
      status: PublishLoadStatus.loading,
    ));

    try {
      await _repository.deleteRental(event.rental.id!);
      emit(state.copyWith(status: PublishLoadStatus.deleted));
    } on Exception catch (err) {
      emit(state.copyWith(
        status: PublishLoadStatus.failed,
        error: (err as dynamic).message,
      ));
    }
  }

  FutureOr<void> _onLoadPhoneNumber(LoadPhoneNumber event, emit) async {
    try {
      final user = await _userRepository.getUserFromCollection();
      if (user != null) {
        emit(state.copyWith(
            phoneNumber: user.hostPhone!,
            status: PublishLoadStatus.phoneLoaded));
      } else {
        throw Exception('Couldn\'t load phone');
      }
    } on Exception catch (err) {
      emit(state.copyWith(
        error: (err as dynamic).message,
        status: PublishLoadStatus.failed,
      ));
    }
  }
}
