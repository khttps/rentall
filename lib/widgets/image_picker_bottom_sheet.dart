import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final Function(List<XFile>) onImagesPicked;
  const ImagePickerBottomSheet({
    required this.onImagesPicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    return Container(
      height: 180.0,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RawMaterialButton(
            padding: const EdgeInsets.all(20.0),
            onPressed: () async {
              Navigator.pop(context);
              final image = await picker.pickImage(
                source: ImageSource.camera,
                imageQuality: 50,
              );

              if (image != null) onImagesPicked([image]);
            },
            elevation: 0.0,
            shape: const CircleBorder(),
            fillColor: Colors.blueGrey,
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 50,
            ),
          ),
          RawMaterialButton(
            padding: const EdgeInsets.all(20.0),
            onPressed: () async {
              Navigator.pop(context);
              final images = await picker.pickMultiImage(imageQuality: 50);
              if (images != null) {
                onImagesPicked(images);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  ErrorSnackbar(message: tr('error_image')),
                );
              }
            },
            elevation: 0.0,
            shape: const CircleBorder(),
            fillColor: Colors.blueGrey,
            child: const Icon(
              Icons.photo,
              color: Colors.white,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
