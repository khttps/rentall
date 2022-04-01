part of 'rentals_bloc.dart';

abstract class RentalsEvent extends Equatable {
  const RentalsEvent();

  @override
  List<Object?> get props => [];
}

class GetRentals extends RentalsEvent {
  const GetRentals();
}

class FilterRentalsByRegion extends RentalsEvent {
  final int? governorateId;
  const FilterRentalsByRegion({this.governorateId});

  @override
  List<Object?> get props => [governorateId];
}

class FilterRentalsByPropertyType extends RentalsEvent {
  final RentalType? type;
  const FilterRentalsByPropertyType({this.type});

  @override
  List<Object?> get props => [type];
}

class ClearRegionFilter extends RentalsEvent {
  const ClearRegionFilter();
}

class ClearPropertyTypeFilter extends RentalsEvent {
  const ClearPropertyTypeFilter();
}
