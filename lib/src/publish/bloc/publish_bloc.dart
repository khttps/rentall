import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentall/src/bloc.dart';
import 'package:rentall/src/rentals/data/data.dart';

part 'publish_event.dart';

class PublishBloc {
  final RentalRepository _repository;
  PublishBloc({required RentalRepository repository})
      : _repository = repository {
    _publishEventController.stream.listen((event) {
      _mapStateToEvent(event);
    });
  }

  List<XFile?> _images = [];
  Rental? _rental;

  final _publishEventController = StreamController<PublishEvent>();
  void add(PublishEvent event) {
    _publishEventController.sink.add(event);
  }

  final _publishStateController = StreamController<BlocState<bool>>();
  StreamSink get _inPublish => _publishStateController.sink;
  Stream<BlocState<bool>> get publish async* {
    try {
      yield const BlocState();
      yield* _publishStateController.stream;
    } on Exception catch (err) {
      print('bloc$err');
      yield BlocState(
        status: LoadStatus.error,
        error: (err as dynamic).message,
      );
    }
  }

  final _imagesStateController = StreamController<List<XFile?>>();
  StreamSink get _inImages => _imagesStateController.sink;
  Stream<List<XFile?>> get images => _imagesStateController.stream;

  void dispose() {
    _publishEventController.close();
    _publishStateController.close();
    _imagesStateController.close();
  }

  void _mapStateToEvent(PublishEvent event) {
    if (event is PublishRental) {
      _repository.addRental(
        Rental.fromMap(event.rental),
        _images.map((img) {
          if (img != null) {
            return File(img.path);
          }
        }).toList(),
      );
      _inPublish.add(const BlocState(
        status: LoadStatus.loaded,
        data: true,
      ));
    } else if (event is AddImages) {
      _images.addAll(event.images);
      _inImages.add(_images);
    } else if (event is RemoveImage) {
      _images.removeAt(event.imageIndex);
      _inImages.add(_images);
    }
  }
}
