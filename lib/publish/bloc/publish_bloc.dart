import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/repository/rental_repository.dart';
import 'package:rentall/bloc/load_status.dart';
import '../../data/model/rental.dart';

part 'publish_state.dart';
part 'publish_event.dart';

class PublishBloc extends Bloc<PublishEvent, PublishState> {
  final RentalRepository _repository;
  PublishBloc({required RentalRepository repository})
      : _repository = repository,
        super(const PublishState()) {
    on<PublishRental>(_onPublishRental);
    on<UpdateRental>(_onUpdateRental);
    on<LoadRental>(_onLoadRental);
  }

  FutureOr<void> _onPublishRental(PublishRental event, emit) async {
    emit(const PublishState(
      status: LoadStatus.reloading,
    ));
    try {
      await _repository.addRental(
        Rental.fromMap(event.rental),
        event.images.map((img) => File(img.path)).toList(),
      );
      emit(const PublishState(status: LoadStatus.success));
    } on Exception catch (err) {
      emit(PublishState(
        status: LoadStatus.failed,
        error: (err as dynamic).message,
      ));
    }
  }

  FutureOr<void> _onUpdateRental(UpdateRental event, emit) {}

  FutureOr<void> _onLoadRental(LoadRental event, emit) {}
}

// class PublishBloc {
//   final RentalRepository _repository;
//   PublishBloc({required RentalRepository repository})
//       : _repository = repository {
//     _publishEventController.stream.listen((event) {
//       _mapStateToEvent(event);
//     });
//   }

//   List<XFile?> _images = [];
//   Rental? _rental;

//   final _publishEventController = StreamController<PublishEvent>.broadcast();
//   void add(PublishEvent event) {
//     _publishEventController.sink.add(event);
//   }

//   final _publishStateController = StreamController<BlocState<bool>>.broadcast();
//   StreamSink get _inPublish => _publishStateController.sink;
//   Stream<BlocState<bool>> get publish async* {
//     try {
//       yield const BlocState();
//       yield* _publishStateController.stream;
//     } on Exception catch (err) {
//       yield BlocState(
//         status: LoadStatus.error,
//         error: (err as dynamic).message,
//       );
//     }
//   }

//   final _imagesStateController = StreamController<List<XFile?>>.broadcast();
//   StreamSink get _inImages => _imagesStateController.sink;
//   Stream<List<XFile?>> get images => _imagesStateController.stream;

//   void dispose() {
//     _publishEventController.close();
//     _publishStateController.close();
//     _imagesStateController.close();
//   }

//   void _mapStateToEvent(PublishEvent event) {
//     if (event is PublishRental) {
//       _repository.addRental(
//         Rental.fromMap(event.rental),
//         _images.map((img) {
//           if (img != null) {
//             return File(img.path);
//           }
//         }).toList(),
//       );
//       _inPublish.add(const BlocState(
//         status: LoadStatus.loaded,
//         data: true,
//       ));
//     } else if (event is AddImages) {
//       _images.addAll(event.images);
//       _inImages.add(_images);
//     } else if (event is RemoveImage) {
//       _images.removeAt(event.imageIndex);
//       _inImages.add(_images);
//     }
//   }
// }
