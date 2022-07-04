import 'package:flutter/material.dart';

class NoImage extends StatelessWidget {
  final double dimension;

  const NoImage({
    required this.dimension,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dimension,
      height: dimension,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          Icons.image_not_supported,
          size: dimension / 1.5,
          color: Colors.grey,
        ),
      ),
    );
  }
}
