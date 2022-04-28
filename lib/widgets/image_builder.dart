import 'dart:io';

import 'package:flutter/material.dart';

class ImageBuilder extends StatelessWidget {
  final String path;
  final double aspectRatio;
  const ImageBuilder({
    required this.path,
    required this.aspectRatio,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.biggest.width;
        return Image.file(
          File(path),
          fit: BoxFit.cover,
          width: maxWidth,
          height: aspectRatio * maxWidth,
          cacheWidth:
              (maxWidth * MediaQuery.of(context).devicePixelRatio).ceil(),
        );
      },
    );
  }
}
