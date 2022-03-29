part of 'rentals_bloc.dart';

abstract class RentalsEvent extends Equatable {
  const RentalsEvent();

  @override
  List<Object?> get props => [];
}

class GetRentals extends RentalsEvent {
  const GetRentals();
}

class FilterRentals extends RentalsEvent {
  final int? governorateId;
  final RentalType? propertyType;
  const FilterRentals({this.governorateId, this.propertyType});

  @override
  List<Object?> get props => [governorateId, propertyType];
}

class ClearRegionFilter extends RentalsEvent {
  const ClearRegionFilter();
}

class ClearPropertyTypeFilter extends RentalsEvent {
  const ClearPropertyTypeFilter();
}
