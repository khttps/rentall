import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum PublishStatus { pending, reviewing, approved, rejected }
enum RentalType { apartment, vacationHome, retailStore, villa, other }
enum RentType { daily, weekly, monthly, other }

class Rental extends Equatable {
  final String title;
  final List<String> images;
  final List<File?>? imageFiles;
  final String description;
  final String address;
  final GeoPoint? location;
  final int? floorNumber;
  final int? numberOfRooms;
  final int? numberOfBathrooms;
  final bool? furnished;
  final int? area;
  final int governorateId;
  final int regionId;
  final int rentPrice;
  final String hostPhoneNumber;
  final Timestamp? createdAt;
  final PublishStatus publishStatus;
  final RentType rentType;
  final RentalType propertyType;

  const Rental({
    required this.title,
    required this.images,
    this.imageFiles,
    required this.description,
    required this.address,
    this.location,
    this.floorNumber,
    this.numberOfRooms,
    this.numberOfBathrooms,
    this.furnished,
    this.area,
    required this.governorateId,
    required this.regionId,
    required this.rentPrice,
    required this.hostPhoneNumber,
    this.createdAt,
    this.publishStatus = PublishStatus.pending,
    this.rentType = RentType.monthly,
    required this.propertyType,
  });

  factory Rental.fromSnapshot(DocumentSnapshot snap) => Rental(
        title: snap['title'],
        images: List.from(snap['images']),
        description: snap['description'],
        address: snap['address'],
        location: snap['location'],
        floorNumber: snap['floorNumber'],
        numberOfRooms: snap['numberOfRooms'],
        numberOfBathrooms: snap['numberOfBathrooms'],
        furnished: snap['furnished'],
        area: snap['area'],
        governorateId: snap['governorateId'],
        regionId: snap['regionId'],
        rentPrice: snap['rentPrice'],
        hostPhoneNumber: snap['hostPhoneNumber'],
        createdAt: snap['createdAt'],
        publishStatus: PublishStatus.values[snap['publishStatus']],
        rentType: RentType.values[snap['rentType']],
        propertyType: RentalType.values[snap['propertyType']],
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
        'publishStatus': r.publishStatus.index,
        'rentType': r.rentType.index,
        'propertyType': r.propertyType.index
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
        publishStatus,
        rentType,
        propertyType,
      ];
}