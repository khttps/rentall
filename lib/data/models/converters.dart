import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<Timestamp?, Timestamp?> {
  const TimestampConverter();

  @override
  Timestamp? fromJson(Timestamp? json) {
    return json;
  }

  @override
  Timestamp? toJson(Timestamp? object) {
    return object;
  }
}

class GeoPointConverter implements JsonConverter<GeoPoint?, GeoPoint?> {
  const GeoPointConverter();

  @override
  GeoPoint? fromJson(GeoPoint? json) {
    return json;
  }

  @override
  GeoPoint? toJson(GeoPoint? object) {
    return object;
  }
}
