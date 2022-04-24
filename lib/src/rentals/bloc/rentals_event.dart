part of 'rentals_bloc.dart';

abstract class RentalsEvent extends Equatable {
  const RentalsEvent();

  @override
  List<Object?> get props => [];
}

class GetRentals extends RentalsEvent {
  const GetRentals();
  @override
  List<Object?> get props => [];
}

class SetRegionFilter extends RentalsEvent {
  final GovernorateFilter governorate;
  const SetRegionFilter({required this.governorate});

  @override
  List<Object?> get props => [governorate];
}

class SetPropertyTypeFilter extends RentalsEvent {
  final PropertyTypeFilter type;
  const SetPropertyTypeFilter({required this.type});

  @override
  List<Object?> get props => [type];
}

// class ClearRegionFilter extends RentalsEvent {
//   const ClearRegionFilter();
// }

// class ClearPropertyTypeFilter extends RentalsEvent {
//   const ClearPropertyTypeFilter();
// }
