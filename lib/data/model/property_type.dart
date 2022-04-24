enum PropertyType {
  all,
  apartment,
  vacationHome,
  retailStore,
  villa,
  other,
}

extension PropertyTypeX on PropertyType {
  int? get value => (index != 0) ? index : null;
}
