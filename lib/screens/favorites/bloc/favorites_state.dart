part of 'favorites_bloc.dart';

enum FavouritesStatus { initial, loading, success, failed }

class FavouritesState extends Equatable {
  final FavouritesStatus status;
  final List<Rental>? favourites;
  final String? message;

  const FavouritesState(
      {this.status = FavouritesStatus.initial, this.favourites, this.message});

  @override
  List<Object?> get props => [status, favourites, message];
}
