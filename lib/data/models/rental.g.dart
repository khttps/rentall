// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rental.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rental _$RentalFromJson(Map<String, dynamic> json) => Rental(
      id: json['id'] as String?,
      title: json['title'] as String,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      description: json['description'] as String?,
      address: json['address'] as String,
      location:
          const GeoPointConverter().fromJson(json['location'] as GeoPoint?),
      floorNumber: json['floorNumber'] as int?,
      rooms: json['rooms'] as int?,
      bathrooms: json['bathrooms'] as int?,
      furnished: json['furnished'] as bool?,
      area: json['area'] as int,
      governorate: $enumDecode(_$GovernorateEnumMap, json['governorate']),
      region: json['region'] as int?,
      price: json['price'] as int,
      hostPhone: json['hostPhone'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      rentPeriod:
          $enumDecodeNullable(_$RentPeriodEnumMap, json['rentPeriod']) ??
              RentPeriod.month,
      availableAt: const TimestampConverter()
          .fromJson(json['availableAt'] as Timestamp?),
      verified: json['verified'] as bool? ?? false,
      propertyType:
          $enumDecodeNullable(_$PropertyTypeEnumMap, json['propertyType']),
      publishStatus:
          $enumDecodeNullable(_$PublishStatusEnumMap, json['publishStatus']),
    );

Map<String, dynamic> _$RentalToJson(Rental instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['title'] = instance.title;
  val['images'] = instance.images;
  writeNotNull('description', instance.description);
  val['address'] = instance.address;
  writeNotNull('location', const GeoPointConverter().toJson(instance.location));
  writeNotNull('floorNumber', instance.floorNumber);
  writeNotNull('rooms', instance.rooms);
  writeNotNull('bathrooms', instance.bathrooms);
  writeNotNull('furnished', instance.furnished);
  val['area'] = instance.area;
  val['governorate'] = _$GovernorateEnumMap[instance.governorate];
  writeNotNull('region', instance.region);
  val['price'] = instance.price;
  val['hostPhone'] = instance.hostPhone;
  val['createdAt'] = const TimestampConverter().toJson(instance.createdAt);
  writeNotNull('rentPeriod', _$RentPeriodEnumMap[instance.rentPeriod]);
  writeNotNull('propertyType', _$PropertyTypeEnumMap[instance.propertyType]);
  writeNotNull(
      'availableAt', const TimestampConverter().toJson(instance.availableAt));
  val['verified'] = instance.verified;
  writeNotNull('publishStatus', _$PublishStatusEnumMap[instance.publishStatus]);
  return val;
}

const _$GovernorateEnumMap = {
  Governorate.all: 'all',
  Governorate.cairo: 'cairo',
  Governorate.giza: 'giza',
  Governorate.alexandria: 'alexandria',
  Governorate.dakahlia: 'dakahlia',
  Governorate.redSea: 'redSea',
  Governorate.beheira: 'beheira',
  Governorate.fayoum: 'fayoum',
  Governorate.gharbiya: 'gharbiya',
  Governorate.ismailia: 'ismailia',
  Governorate.menofia: 'menofia',
  Governorate.minya: 'minya',
  Governorate.qaliubiya: 'qaliubiya',
  Governorate.newValley: 'newValley',
  Governorate.suez: 'suez',
  Governorate.aswan: 'aswan',
  Governorate.assiut: 'assiut',
  Governorate.beniSuef: 'beniSuef',
  Governorate.portSaid: 'portSaid',
  Governorate.damietta: 'damietta',
  Governorate.sharkia: 'sharkia',
  Governorate.southSinai: 'southSinai',
  Governorate.kafrAlSheikh: 'kafrAlSheikh',
  Governorate.matrouh: 'matrouh',
  Governorate.luxor: 'luxor',
  Governorate.qena: 'qena',
  Governorate.northSinai: 'northSinai',
  Governorate.sohag: 'sohag',
};

const _$RentPeriodEnumMap = {
  RentPeriod.all: 'all',
  RentPeriod.day: 'day',
  RentPeriod.month: 'month',
  RentPeriod.week: 'week',
  RentPeriod.custom: 'custom',
};

const _$PropertyTypeEnumMap = {
  PropertyType.all: 'all',
  PropertyType.apartment: 'apartment',
  PropertyType.vacationHome: 'vacationHome',
  PropertyType.retailStore: 'retailStore',
  PropertyType.villa: 'villa',
  PropertyType.other: 'other',
};

const _$PublishStatusEnumMap = {
  PublishStatus.pending: 'pending',
  PublishStatus.approved: 'approved',
  PublishStatus.rejected: 'rejected',
  PublishStatus.booked: 'booked',
};
