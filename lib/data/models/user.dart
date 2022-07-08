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
  final String? avatarUrl;
  final String? hostPhone;
  @JsonKey(includeIfNull: false)
  final List<Rental>? rentals;

  const User({
    required this.uid,
    this.displayName,
    required this.email,
    this.hostName,
    this.avatarUrl,
    this.hostPhone,
    this.rentals,
    this.favorites,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromAuthUser(auth.User user) => User(
        uid: user.uid,
        displayName: user.displayName,
        email: user.email!,
      );

  @override
  List<Object?> get props => [uid, displayName, email, favorites];
}