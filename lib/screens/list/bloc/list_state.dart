part of 'list_bloc.dart';

enum FavouritesStatus { initial, loading, success, failed }

class ListState extends Equatable {
  final FavouritesStatus status;
  final List<Rental>? favourites;
  final String? message;

  const ListState(
      {this.status = FavouritesStatus.initial, this.favourites, this.message});

  @override
  List<Object?> get props => [status, favourites, message];
}
