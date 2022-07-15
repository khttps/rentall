part of 'owner_cubit.dart';

abstract class OwnerState extends Equatable {
  const OwnerState();

  @override
  List<Object> get props => [];
}

class OwnerInitial extends OwnerState {}

class OwnerLoading extends OwnerState {
  const OwnerLoading();
  @override
  List<Object> get props => [];
}

class OwnerLoaded extends OwnerState {
  final User owner;
  const OwnerLoaded({required this.owner});

  @override
  List<Object> get props => [owner];
}

class OwnerError extends OwnerState {
  final String message;
  const OwnerError({required this.message});

  @override
  List<Object> get props => [message];
}
