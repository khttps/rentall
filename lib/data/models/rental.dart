import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'converters.dart';
import 'models.dart';

part 'rental.g.dart';

@JsonSerializable()
class Rental extends Equatable {
  @JsonKey(includeIfNull: false)
  final String? id;
  @JsonKey(includeIfNull: false)
  final String? userId;
  final String title;
  final List<String> images;
  @JsonKey(includeIfNull: false)
  final String? description;
  final String address;
  @JsonKey(includeIfNull: false)
  @GeoPointConverter()
  final GeoPoint? location;
  @JsonKey(includeIfNull: false)
  final int? floorNumber;
  @JsonKey(includeIfNull: false)
  final int? rooms;
  @JsonKey(includeIfNull: false)
  final int? bathrooms;
  @JsonKey(includeIfNull: false)
  final bool? furnished;
  final int area;
  final Governorate governorate;
  @JsonKey(includeIfNull: false)
  final String? region;
  final int price;
  final String hostPhone;
  @TimestampConverter()
  @JsonKey(includeIfNull: false)
  final Timestamp? createdAt;
  @JsonKey(includeIfNull: false)
  final RentPeriod? rentPeriod;
  @JsonKey(includeIfNull: false)
  final PropertyType? propertyType;
  @JsonKey(includeIfNull: false)
  final PublishStatus? publishStatus;
  @JsonKey(includeIfNull: false)
  final String? rejectReason;

  const Rental({
    this.id,
    this.userId,
    required this.title,
    this.images = const [],
    this.description,
    required this.address,
    this.location,
    this.floorNumber,
    this.rooms,
    this.bathrooms,
    this.furnished,
    required this.area,
    required this.governorate,
    this.region,
    required this.price,
    required this.hostPhone,
    this.createdAt,
    this.rentPeriod = RentPeriod.month,
    required this.propertyType,
    this.publishStatus,
    this.rejectReason,
  });

  factory Rental.fromJson(Map<String, dynamic> json) => _$RentalFromJson(json);
  Map<String, dynamic> toJson() => _$RentalToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        images,
        description,
        address,
        floorNumber,
        rooms,
        bathrooms,
        governorate,
        furnished,
        area,
        region,
        price,
        hostPhone,
        createdAt,
        rentPeriod,
        propertyType,
        rejectReason
      ];
}
