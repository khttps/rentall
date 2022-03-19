part of 'rentals_bloc.dart';

abstract class RentalsEvent extends Equatable {
  const RentalsEvent();

  @override
  List<Object?> get props => [];
}

class GetRentals extends RentalsEvent {
  final PropertyType? propertyType;
  final RentType? rentType;
  final int? governorateId;
  final int? regionId;
  final String? searchKeyword;
  final int? priceFrom;
  final int? priceTo;

  const GetRentals({
    this.propertyType,
    this.rentType,
    this.governorateId,
    this.regionId,
    this.searchKeyword,
    this.priceFrom,
    this.priceTo,
  }) : assert(!((priceTo == null) ^ (priceFrom == null)));

  @override
  List<Object?> get props => [
        propertyType,
        rentType,
        governorateId,
        regionId,
        searchKeyword,
        priceFrom,
        priceTo,
      ];
}
