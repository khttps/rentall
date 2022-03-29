part of 'rentals_bloc.dart';

enum LoadStatus { loading, loaded, error }

class RentalsState extends Equatable {
  final LoadStatus status;
  final List<Rental>? rentals;
  final String? error;
  final int? priceTo;
  final int? priceFrom;
  final RentalType? propertyType;
  final int? governorateId;

  const RentalsState({
    this.status = LoadStatus.loading,
    this.rentals,
    this.error,
    this.priceTo,
    this.priceFrom,
    this.propertyType,
    this.governorateId,
  })  : assert(!((status == LoadStatus.loaded) ^ (rentals != null))),
        assert(!((status == LoadStatus.error) ^ (error != null)));

  RentalsState copyWith({
    LoadStatus status = LoadStatus.loading,
    List<Rental>? rentals,
    String? error,
    int? priceTo,
    int? priceFrom,
    RentalType? propertyType,
    int? governorateId,
  }) =>
      RentalsState(
        status: status,
        rentals: rentals ?? this.rentals,
        error: error,
        priceTo: priceTo ?? this.priceTo,
        priceFrom: priceFrom ?? this.priceFrom,
        propertyType: propertyType ?? this.propertyType,
        governorateId: governorateId ?? this.governorateId,
      );

  @override
  List<Object?> get props => [
        status,
        rentals,
        error,
        priceTo,
        priceFrom,
        propertyType,
        governorateId,
      ];
}
