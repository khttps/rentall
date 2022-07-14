part of 'rentals_bloc.dart';

enum RentalsLoadStatus { loading, reloading, success, failed }

class RentalsState extends Equatable {
  final RentalsLoadStatus status;
  final List<Rental>? rentals;
  final String? error;
  final Governorate governorate;
  final PropertyType? type;
  final RentPeriod? period;
  final int? priceFrom;
  final int? priceTo;

  const RentalsState({
    this.status = RentalsLoadStatus.loading,
    this.rentals,
    this.error,
    this.governorate = Governorate.all,
    this.type,
    this.period,
    this.priceFrom,
    this.priceTo,
  });

  RentalsState copyWith({
    RentalsLoadStatus? status,
    List<Rental>? rentals,
    String? error,
    Governorate? governorate,
    PropertyType? type,
    RentPeriod? period,
    int? priceFrom,
    int? priceTo,
  }) =>
      RentalsState(
        status: status ?? this.status,
        rentals: rentals ?? this.rentals,
        error: error,
        governorate: governorate ?? this.governorate,
        type: type ?? this.type,
        period: period ?? this.period,
        priceFrom: priceFrom == 0 ? null : priceFrom ?? this.priceFrom,
        priceTo: priceTo == 0 ? null : priceTo ?? this.priceTo,
      );

  String get priceText {
    if (priceFrom != null && priceTo != null) {
      return tr(
        'price_from_to',
        args: [priceFrom.toString(), priceTo.toString()],
      );
    } else if (priceFrom != null && priceTo == null) {
      return tr('price_from').tr(args: [priceFrom.toString()]);
    }
    if (priceFrom == null && priceTo != null) {
      return tr('price_to').tr(args: [priceTo.toString()]);
    }
    return tr('price');
  }

  Map<String, dynamic> get filters => {
        'governorate': governorate,
        'propertyType': type,
        'rentPeriod': period,
        'priceFrom': priceFrom,
        'priceTo': priceTo,
      };

  @override
  List<Object?> get props => [
        status,
        rentals,
        error,
        governorate,
        type,
        period,
        priceFrom,
        priceTo,
      ];
}
