part of 'host_bloc.dart';

abstract class HostEvent extends Equatable {
  const HostEvent();

  @override
  List<Object?> get props => [];
}

class SetupHost extends HostEvent {
  final Map<String, dynamic> host;
  final File? image;

  const SetupHost({required this.host, this.image});

  @override
  List<Object?> get props => [host, image];
}

class LoadHost extends HostEvent {
  const LoadHost();

  @override
  List<Object?> get props => [];
}
