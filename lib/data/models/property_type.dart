enum PropertyType {
  all,
  apartment,
  vacationHome,
  retailStore,
  villa,
  hotel,
  other,
}

extension PropertyTypeX on PropertyType {
  String? get value => (index != 0) ? name : null;

  String? get markerRes => (index != 0) ? 'assets/markers/$name.png' : null;
}
