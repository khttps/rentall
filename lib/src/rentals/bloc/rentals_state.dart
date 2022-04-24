part of 'rentals_bloc.dart';

enum LoadStatus { loading, success, failed }

class RentalsState extends Equatable {
  final LoadStatus status;
  final List<Rental>? rentals;
  final String? error;
  final GovernorateFilter governorate;
  final PropertyTypeFilter type;

  const RentalsState({
    this.status = LoadStatus.loading,
    this.rentals,
    this.error,
    this.governorate = GovernorateFilter.all,
    this.type = PropertyTypeFilter.all,
  });

  RentalsState copyWith({
    LoadStatus? status,
    List<Rental>? rentals,
    String? error,
    GovernorateFilter? governorate,
    PropertyTypeFilter? type,
  }) =>
      RentalsState(
        status: status ?? this.status,
        rentals: rentals ?? this.rentals,
        error: error,
        governorate: governorate ?? this.governorate,
        type: type ?? this.type,
      );

  @override
  List<Object?> get props => [
        status,
        rentals,
        error,
        governorate,
        type,
      ];
}
