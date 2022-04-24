enum PropertyTypeFilter {
  all,
  apartment,
  vacationHome,
  retailStore,
  villa,
}

extension PropertyTypeFilterX on PropertyTypeFilter {
  int? get value => (index != 0) ? index : null;
}
