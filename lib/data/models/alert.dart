import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Alert extends Equatable {
  final String? id;
  final List<String> keywords;
  final Timestamp? createdAt;

  const Alert({
    this.id,
    required this.keywords,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, keywords, createdAt];

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
      id: json['id'],
      keywords: (json['keywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'keywords': keywords,
        'createdAt': createdAt,
      };
}
