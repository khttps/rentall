part of 'publish_bloc.dart';

abstract class PublishEvent extends Equatable {
  const PublishEvent();

  @override
  List<Object?> get props => [];
}

class PublishRental extends PublishEvent {
  final Map<String, dynamic> rentalMap;
  final List<XFile> images;

  const PublishRental({required this.rentalMap, required this.images});

  @override
  List<Object?> get props => [rentalMap, images];
}

class UpdateRental extends PublishEvent {
  final String id;
  final Map<String, dynamic> rental;
  final List<XFile>? images;

  const UpdateRental({
    required this.id,
    required this.rental,
    required this.images,
  });

  @override
  List<Object?> get props => [id, rental, images];
}

class DeleteRental extends PublishEvent {
  final String id;
  const DeleteRental({required this.id});

  @override
  List<Object?> get props => [id];
}
