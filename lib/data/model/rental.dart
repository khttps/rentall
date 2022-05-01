import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'governorate.dart';
import 'property_type.dart';

enum RentType { daily, weekly, monthly, other }
enum PublishStatus { pending, reviewing, approved, rejected }

class Rental extends Equatable {
  final String title;
  final List<String> images;
  final String? description;
  final String address;
  final GeoPoint? location;
  final int? floorNumber;
  final int? numberOfRooms;
  final int? numberOfBathrooms;
  final bool? furnished;
  final int? area;
  final Governorate governorate;
  final int? regionId;
  final int rentPrice;
  final String hostPhoneNumber;
  final Timestamp? createdAt;
  final RentType? rentType;
  final PropertyType? propertyType;
  final PublishStatus? publishStatus;

  const Rental({
    required this.title,
    this.images = const [],
    this.description,
    required this.address,
    this.location,
    this.floorNumber,
    this.numberOfRooms,
    this.numberOfBathrooms,
    this.furnished,
    this.area,
    required this.governorate,
    this.regionId,
    required this.rentPrice,
    required this.hostPhoneNumber,
    this.createdAt,
    this.rentType = RentType.monthly,
    required this.propertyType,
    this.publishStatus,
  });

  factory Rental.fromMap(dynamic map) => Rental(
        title: map['title'],
        images: List.from(map['images'] ?? []),
        description: map['description'],
        address: map['address'],
        location: map['location'],
        floorNumber: map['floorNumber'],
        numberOfRooms: map['numberOfRooms'],
        numberOfBathrooms: map['numberOfBathrooms'],
        furnished: map['furnished'],
        area: map['area'],
        governorate: Governorate.values[map['governorateId']],
        regionId: map['regionId'],
        rentPrice: map['rentPrice'],
        hostPhoneNumber: map['hostPhoneNumber'],
        createdAt: map['createdAt'],
        rentType: RentType.values[map['rentType']],
        propertyType: PropertyType.values[map['propertyType']],
        publishStatus: map['publishStatus'] != null
            ? PublishStatus.values[map['publishStatus']]
            : null,
      );

  static Map<String, dynamic> toMap(Rental r) => {
        'title': r.title,
        'images': r.images,
        'description': r.description,
        'address': r.address,
        'location': r.location,
        'floorNumber': r.floorNumber,
        'numberOfRooms': r.numberOfRooms,
        'numberOfBathrooms': r.numberOfBathrooms,
        'area': r.area,
        'furnished': r.furnished,
        'governorateId': r.governorate.index,
        'regionId': r.regionId,
        'rentPrice': r.rentPrice,
        'hostPhoneNumber': r.hostPhoneNumber,
        'createdAt': r.createdAt ?? Timestamp.now(),
        'rentType': r.rentType?.index,
        'propertyType': r.propertyType?.index,
      };

  @override
  List<Object?> get props => [
        title,
        images,
        description,
        address,
        floorNumber,
        numberOfRooms,
        numberOfBathrooms,
        governorate,
        furnished,
        area,
        regionId,
        rentPrice,
        hostPhoneNumber,
        createdAt,
        rentType,
        propertyType,
      ];
}
