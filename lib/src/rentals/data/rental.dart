import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum PublishStatus { pending, reviewing, approved, rejected }
enum RentalType { apartment, vacationHome, retailStore, villa, other }
enum RentType { daily, weekly, monthly, other }

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
  final int governorateId;
  final int? regionId;
  final int rentPrice;
  final String hostPhoneNumber;
  final Timestamp? createdAt;
  final RentType? rentType;
  final RentalType? propertyType;

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
    required this.governorateId,
    this.regionId,
    required this.rentPrice,
    required this.hostPhoneNumber,
    this.createdAt,
    this.rentType = RentType.monthly,
    required this.propertyType,
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
        governorateId: map['governorateId'],
        regionId: map['regionId'],
        rentPrice: map['rentPrice'],
        hostPhoneNumber: map['hostPhoneNumber'],
        createdAt: map['createdAt'],
        rentType: RentType.values[map['rentType']],
        propertyType: RentalType.values[map['propertyType']],
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
        'governorateId': r.governorateId,
        'regionId': r.regionId,
        'rentPrice': r.rentPrice,
        'hostPhoneNumber': r.hostPhoneNumber,
        'createdAt': r.createdAt ?? Timestamp.now(),
        'rentType': r.rentType?.index,
        'propertyType': r.propertyType?.index
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
        governorateId,
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
