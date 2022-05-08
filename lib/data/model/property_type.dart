enum PropertyType {
  all,
  apartment,
  vacationHome,
  retailStore,
  villa,
  other,
}

extension PropertyTypeX on PropertyType {
  String? get value => (index != 0) ? name : null;
}
