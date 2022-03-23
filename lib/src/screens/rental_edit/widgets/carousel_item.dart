import 'dart:io';
import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  final String path;
  const CarouselItem({required this.path, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      child: Image.network(
        path,
        fit: BoxFit.cover,
      ),
    );
  }
}
