import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets.dart';

class ImageCircleAvatar extends StatefulWidget {
  final double radius;
  final IconData? icon;
  final Function(File? image) onAdded;
  final String? initialImage;
  const ImageCircleAvatar({
    required this.radius,
    this.icon,
    required this.onAdded,
    this.initialImage,
    Key? key,
  }) : super(key: key);

  @override
  State<ImageCircleAvatar> createState() => _ImageCircleAvatarState();
}

class _ImageCircleAvatarState extends State<ImageCircleAvatar> {
  late String? _image;
  File? _fileImage;

  @override
  void initState() {
    super.initState();
    _image = widget.initialImage;
  }

  @override
  Widget build(BuildContext context) {
    dynamic imageProvider;
    setState(() {
      imageProvider = _fileImage != null
          ? FileImage(_fileImage!)
          : (_image != null)
              ? CachedNetworkImageProvider(_image!)
              : null;
    });

    final hasImage = imageProvider != null;

    return Center(
      child: CircleAvatar(
        radius: widget.radius,
        backgroundImage: imageProvider,
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
            () => _fileImage = File(images[0].path),
          );
          widget.onAdded(_fileImage!);
        },
      ),
    );
  }
}
