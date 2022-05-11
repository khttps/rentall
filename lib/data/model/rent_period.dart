enum RentPeriod {
  all,
  day,
  month,
  week,
  custom,
}

extension RentPeriodX on RentPeriod {
  String? get value => (index != 0) ? name : null;
}
