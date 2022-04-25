part of 'publish_bloc.dart';

abstract class PublishEvent extends Equatable {
  const PublishEvent();

  @override
  List<Object?> get props => [];
}

class PublishRental extends PublishEvent {
  final Map<String, dynamic> rental;
  final List<XFile> images;

  const PublishRental({required this.rental, required this.images});

  @override
  List<Object?> get props => [rental, images];
}

// class AddImages extends PublishEvent {
//   final List<XFile?> images;
//   const AddImages({required this.images});
// }

// class RemoveImage extends PublishEvent {
//   final int imageIndex;
//   const RemoveImage({required this.imageIndex});

//   @override
//   List<Object?> get props => [imageIndex];
// }

class UpdateRental extends PublishEvent {
  final Map<String, dynamic> rental;
  final List<XFile?> images;

  const UpdateRental({required this.rental, required this.images});

  @override
  List<Object?> get props => [rental, images];
}

class LoadRental extends PublishEvent {
  final Rental rental;
  const LoadRental({required this.rental});

  @override
  List<Object?> get props => [rental];
}
