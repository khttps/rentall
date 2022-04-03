part of '../rentals/bloc/rentals_bloc.dart';

enum LoadStatus { loading, loaded, error }

class BlocState<T> extends Equatable {
  final LoadStatus status;
  final T? data;
  final String? error;

  const BlocState({this.status = LoadStatus.loading, this.data, this.error});

  @override
  List<Object?> get props => [status, data, error];
}
