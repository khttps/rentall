part of 'host_bloc.dart';

enum HostStatus { saving, saved, initial, error, loaded, loading }

class HostState extends Equatable {
  final HostStatus status;
  final User? user;
  final String? message;
  const HostState({
    this.status = HostStatus.initial,
    this.user,
    this.message,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        user,
      ];

  HostState copyWith({
    HostStatus? status,
    User? user,
    String? message,
  }) =>
      HostState(
        status: status ?? this.status,
        user: user ?? this.user,
        message: message ?? this.message,
      );
}
