// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      uid: json['uid'] as String,
      displayName: json['displayName'] as String?,
      email: json['email'] as String,
      hostName: json['hostName'] as String?,
      hostAvatar: json['hostAvatar'] as String?,
      hostPhone: json['hostPhone'] as String?,
      rentals: (json['rentals'] as List<dynamic>?)
          ?.map((e) => Rental.fromJson(e as Map<String, dynamic>))
          .toList(),
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => Rental.fromJson(e as Map<String, dynamic>))
          .toList(),
      verified: json['verified'] as bool? ?? false,
      provider: json['provider'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{
    'uid': instance.uid,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('displayName', instance.displayName);
  val['email'] = instance.email;
  writeNotNull('favorites', instance.favorites);
  val['hostName'] = instance.hostName;
  writeNotNull('hostAvatar', instance.hostAvatar);
  val['hostPhone'] = instance.hostPhone;
  writeNotNull('rentals', instance.rentals);
  val['verified'] = instance.verified;
  writeNotNull('provider', instance.provider);
  return val;
}
