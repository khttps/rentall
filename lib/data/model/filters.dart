import 'package:equatable/equatable.dart';

import 'governorate.dart';
import 'property_type.dart';

class Filters extends Equatable {
  final PropertyType? propertyType;
  final Governorate? governorate;

  const Filters({this.governorate, this.propertyType});

  @override
  List<Object?> get props => [propertyType, governorate];
}
