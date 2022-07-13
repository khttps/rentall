import 'package:flutter/material.dart';

enum PublishStatus { pending, approved, rejected, archived }

extension PublishStatusX on PublishStatus {
  Color get color {
    final colors = [
      Colors.orange,
      Colors.green,
      Colors.red,
      Colors.red.shade900,
    ];

    return colors[index];
  }
}
