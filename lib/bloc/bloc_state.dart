import 'package:equatable/equatable.dart';

import 'load_status.dart';

class BlocState<T> extends Equatable {
  final LoadStatus status;
  final T? data;
  final String? error;

  const BlocState({this.status = LoadStatus.loading, this.data, this.error});

  @override
  List<Object?> get props => [status, data, error];
}
