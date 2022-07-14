import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String uid;
  @JsonKey(includeIfNull: false)
  final String? displayName;
  final String email;
  @JsonKey(includeIfNull: false)
  @JsonKey(includeIfNull: false)
  final List<Rental>? favorites;
  final String? hostName;
  @JsonKey(includeIfNull: false)
  final String? hostAvatar;
  final String? hostPhone;
  @JsonKey(includeIfNull: false)
  final List<Rental>? rentals;
  @JsonKey(defaultValue: false)
  final bool verified;

  const User({
    required this.uid,
    this.displayName,
    required this.email,
    this.hostName,
    this.hostAvatar,
    this.hostPhone,
    this.rentals,
    this.favorites,
    required this.verified,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromAuthUser(auth.User user) => User(
        uid: user.uid,
        displayName: user.displayName,
        email: user.email!,
        verified: user.emailVerified,
      );

  @override
  List<Object?> get props => [
        uid,
        displayName,
        email,
        favorites,
        rentals,
        hostPhone,
        hostName,
        hostAvatar,
        verified
      ];
}
