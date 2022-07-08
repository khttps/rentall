import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/rental.dart';
import '../../../data/repository/rental_repository.dart';

part 'publish_state.dart';
part 'publish_event.dart';

class PublishBloc extends Bloc<PublishEvent, PublishState> {
  final RentalRepository _repository;
  PublishBloc({required RentalRepository repository})
      : _repository = repository,
        super(const PublishState()) {
    on<PublishRental>(_onPublishRental);
    on<UpdateRental>(_onUpdateRental);
    on<ArchiveRental>(_onArchiveRental);
  }

  FutureOr<void> _onPublishRental(PublishRental event, emit) async {
    emit(const PublishState(
      status: PublishLoadStatus.loading,
    ));
    try {
      final rental = await _repository.addRental(
        event.rentalMap,
        event.images.map((img) => File(img.path)).toList(),
      );

      emit(PublishState(
        status: PublishLoadStatus.published,
        rental: rental,
      ));
    } on Exception catch (err) {
      emit(PublishState(
        status: PublishLoadStatus.failed,
        error: (err as dynamic).message,
      ));
    }
  }

  FutureOr<void> _onUpdateRental(UpdateRental event, emit) async {
    emit(const PublishState(
      status: PublishLoadStatus.loading,
    ));
    try {
      final rental = await _repository.updateRental(
        event.id,
        event.rental,
        event.images?.map((img) => File(img.path)).toList(),
      );

      emit(PublishState(
        status: PublishLoadStatus.published,
        rental: rental,
      ));
    } on Exception catch (err) {
      emit(PublishState(
        status: PublishLoadStatus.failed,
        error: (err as dynamic).message,
      ));
    }
  }

  FutureOr<void> _onArchiveRental(ArchiveRental event, emit) async {
    emit(const PublishState(
      status: PublishLoadStatus.loading,
    ));
    try {
      await _repository.archiveRental(event.id);
      emit(const PublishState(status: PublishLoadStatus.deleted));
    } on Exception catch (err) {
      emit(PublishState(
        status: PublishLoadStatus.failed,
        error: (err as dynamic).message,
      ));
    }
  }
}
