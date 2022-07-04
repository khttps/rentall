import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets.dart';

class ImageCircleAvatar extends StatefulWidget {
  final double radius;
  final IconData icon;
  const ImageCircleAvatar({
    required this.radius,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  State<ImageCircleAvatar> createState() => _ImageCircleAvatarState();
}

class _ImageCircleAvatarState extends State<ImageCircleAvatar> {
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    final hasImage = _image != null;

    return Center(
      child: CircleAvatar(
        radius: widget.radius,
        backgroundImage: hasImage ? FileImage(File(_image!.path)) : null,
        child: InkWell(
          onTap: () async {
            await _showBottomSheet(context);
          },
          child:
              !hasImage ? Icon(widget.icon, size: widget.radius * 1.3) : null,
        ),
      ),
    );
  }

  Future<dynamic> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => ImagePickerBottomSheet(
        onImagesPicked: (images) => setState(
          () => _image = images[0],
        ),
      ),
    );
  }
}
