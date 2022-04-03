part of 'publish_bloc.dart';

abstract class PublishEvent extends Equatable {
  const PublishEvent();

  @override
  List<Object?> get props => [];
}

class PublishRental extends PublishEvent {
  final Map<String, dynamic> rental;

  const PublishRental({required this.rental});

  @override
  List<Object?> get props => [rental];
}

class AddImages extends PublishEvent {
  final List<XFile?> images;
  const AddImages({required this.images});
}

class RemoveImage extends PublishEvent {
  final int imageIndex;
  const RemoveImage({required this.imageIndex});

  @override
  List<Object?> get props => [imageIndex];
}

class UpdateRental extends PublishEvent {
  final Rental rental;

  const UpdateRental({required this.rental});

  @override
  List<Object?> get props => [rental];
}

class LoadRental extends PublishEvent {
  final int id;
  const LoadRental({required this.id});

  @override
  List<Object?> get props => [id];
}
