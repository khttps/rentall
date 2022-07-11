import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets.dart';

class ImageCircleAvatar extends StatefulWidget {
  final double radius;
  final IconData icon;
  final Function(XFile? image) onAdded;
  final String? initialImage;
  const ImageCircleAvatar({
    required this.radius,
    required this.icon,
    required this.onAdded,
    this.initialImage,
    Key? key,
  }) : super(key: key);

  @override
  State<ImageCircleAvatar> createState() => _ImageCircleAvatarState();
}

class _ImageCircleAvatarState extends State<ImageCircleAvatar> {
  late dynamic _image = widget.initialImage;

  @override
  Widget build(BuildContext context) {
    final hasImage = _image != null;
    final dynamic imageProvider = hasImage
        ? (_image is String)
            ? CachedNetworkImageProvider(_image)
            : FileImage(File(_image.path))
        : null;

    return Center(
      child: CircleAvatar(
        radius: widget.radius,
        backgroundImage: hasImage ? imageProvider : null,
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
        onImagesPicked: (images) {
          setState(
            () => _image = images[0],
          );
          widget.onAdded(_image);
        },
      ),
    );
  }
}
