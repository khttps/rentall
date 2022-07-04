enum Governorate {
  all,
  cairo,
  giza,
  alexandria,
  dakahlia,
  redSea,
  beheira,
  fayoum,
  gharbiya,
  ismailia,
  menofia,
  minya,
  qaliubiya,
  newValley,
  suez,
  aswan,
  assiut,
  beniSuef,
  portSaid,
  damietta,
  sharkia,
  southSinai,
  kafrAlSheikh,
  matrouh,
  luxor,
  qena,
  northSinai,
  sohag,
}

extension GovernorateX on Governorate {
  String? get value => (index != 0) ? name : null;
}
