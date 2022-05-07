// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'rental.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:rentall/data/model/rental.dart';

// Rental _$RentalFromJson(Map<String, dynamic> json) => Rental(
//       id: json['id'] as String?,
//       title: json['title'] as String,
//       images: (json['images'] as List<dynamic>?)
//               ?.map((e) => e as String)
//               .toList() ??
//           const [],
//       description: json['description'] as String?,
//       address: json['address'] as String,
//       location:
//           const GeoPointConverter().fromJson(json['location'] as GeoPoint?),
//       floorNumber: json['floorNumber'] as int?,
//       numberOfRooms: json['numberOfRooms'] as int?,
//       numberOfBathrooms: json['numberOfBathrooms'] as int?,
//       furnished: json['furnished'] as bool?,
//       area: json['area'] as int?,
//       governorate: $enumDecode(_$GovernorateEnumMap, json['governorateId']),
//       regionId: json['regionId'] as int?,
//       rentPrice: json['rentPrice'] as int,
//       hostPhoneNumber: json['hostPhoneNumber'] as String,
//       createdAt:
//           const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
//       rentType: $enumDecodeNullable(_$RentTypeEnumMap, json['rentType']) ??
//           RentType.monthly,
//       propertyType:
//           $enumDecodeNullable(_$PropertyTypeEnumMap, json['propertyType']),
//       publishStatus:
//           $enumDecodeNullable(_$PublishStatusEnumMap, json['publishStatus']),
//     );

// Map<String, dynamic> _$RentalToJson(Rental instance) {
//   final val = <String, dynamic>{};

//   void writeNotNull(String key, dynamic value) {
//     if (value != null) {
//       val[key] = value;
//     }
//   }

//   writeNotNull('id', instance.id);
//   val['title'] = instance.title;
//   val['images'] = instance.images;
//   writeNotNull('description', instance.description);
//   val['address'] = instance.address;
//   writeNotNull('location', const GeoPointConverter().toJson(instance.location));
//   writeNotNull('floorNumber', instance.floorNumber);
//   writeNotNull('numberOfRooms', instance.numberOfRooms);
//   writeNotNull('numberOfBathrooms', instance.numberOfBathrooms);
//   writeNotNull('furnished', instance.furnished);
//   writeNotNull('area', instance.area);
//   val['governorateId'] = _$GovernorateEnumMap[instance.governorate];
//   writeNotNull('regionId', instance.regionId);
//   val['rentPrice'] = instance.rentPrice;
//   val['hostPhoneNumber'] = instance.hostPhoneNumber;
//   val['createdAt'] = const TimestampConverter().toJson(instance.createdAt);
//   writeNotNull('rentType', _$RentTypeEnumMap[instance.rentType]);
//   val['propertyType'] = _$PropertyTypeEnumMap[instance.propertyType];
//   val['publishStatus'] = _$PublishStatusEnumMap[instance.publishStatus];
//   return val;
// }

// const _$GovernorateEnumMap = {
//   Governorate.all: 'all',
//   Governorate.cairo: 'cairo',
//   Governorate.giza: 'giza',
//   Governorate.alexandria: 'alexandria',
//   Governorate.dakahlia: 'dakahlia',
//   Governorate.redSea: 'redSea',
//   Governorate.beheira: 'beheira',
//   Governorate.fayoum: 'fayoum',
//   Governorate.gharbiya: 'gharbiya',
//   Governorate.ismailia: 'ismailia',
//   Governorate.menofia: 'menofia',
//   Governorate.minya: 'minya',
//   Governorate.qaliubiya: 'qaliubiya',
//   Governorate.newValley: 'newValley',
//   Governorate.suez: 'suez',
//   Governorate.aswan: 'aswan',
//   Governorate.assiut: 'assiut',
//   Governorate.beniSuef: 'beniSuef',
//   Governorate.portSaid: 'portSaid',
//   Governorate.damietta: 'damietta',
//   Governorate.sharkia: 'sharkia',
//   Governorate.southSinai: 'southSinai',
//   Governorate.kafrAlSheikh: 'kafrAlSheikh',
//   Governorate.matrouh: 'matrouh',
//   Governorate.luxor: 'luxor',
//   Governorate.qena: 'qena',
//   Governorate.northSinai: 'northSinai',
//   Governorate.sohag: 'sohag',
// };

// const _$RentTypeEnumMap = {
//   RentType.daily: 'daily',
//   RentType.weekly: 'weekly',
//   RentType.monthly: 'monthly',
//   RentType.other: 'other',
// };

// const _$PropertyTypeEnumMap = {
//   PropertyType.all: 'all',
//   PropertyType.apartment: 'apartment',
//   PropertyType.vacationHome: 'vacationHome',
//   PropertyType.retailStore: 'retailStore',
//   PropertyType.villa: 'villa',
//   PropertyType.other: 'other',
// };

// const _$PublishStatusEnumMap = {
//   PublishStatus.pending: 'pending',
//   PublishStatus.reviewing: 'reviewing',
//   PublishStatus.approved: 'approved',
//   PublishStatus.rejected: 'rejected',
// };
