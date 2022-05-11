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
  final Governorate governorate;
  const SetRegionFilter({required this.governorate});

  @override
  List<Object?> get props => [governorate];
}

class SetPropertyTypeFilter extends RentalsEvent {
  final PropertyType type;
  const SetPropertyTypeFilter({required this.type});

  @override
  List<Object?> get props => [type];
}

class SetPriceFilter extends RentalsEvent {
  final int? priceFrom;
  final int? priceTo;
  const SetPriceFilter({this.priceFrom, this.priceTo});

  @override
  List<Object?> get props => [priceFrom, priceTo];
}

class SetPeriodFilter extends RentalsEvent {
  final RentPeriod period;
  const SetPeriodFilter({required this.period});
}
