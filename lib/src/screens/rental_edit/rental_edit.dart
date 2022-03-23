import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart' as ezl;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentall/src/screens/rental_edit/widgets/carousel_item.dart';

import 'widgets/rental_form.dart';

class RentalEdit extends StatefulWidget {
  static const routeName = '/rental_edit';
  const RentalEdit({Key? key}) : super(key: key);

  @override
  State<RentalEdit> createState() => _RentalEditState();
}

class _RentalEditState extends State<RentalEdit> {
  final _picker = ImagePicker();
  final _pickedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (c, i) => const [
          SliverAppBar(
            snap: true,
            floating: true,
            forceElevated: true,
            title: Text('New Rental'),
          ),
        ],
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              height: 180.0,
              child: CarouselSlider.builder(
                itemCount: 1 + _pickedImages.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: index == _pickedImages.length
                        ? Center(
                            child: FloatingActionButton(
                              onPressed: () => _showBottomSheet(context),
                              heroTag: 'add_photo',
                              child: const Icon(Icons.add_a_photo),
                            ),
                          )
                        : Image.file(
                            File(_pickedImages[index].path),
                            fit: BoxFit.cover,
                          ),
                  );
                },
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 10,
                  viewportFraction: 0.5,
                ),
              ),
            ),
            const RentalForm(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        heroTag: 'save',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  _showBottomSheet(BuildContext context) => showBottomSheet(
        context: context,
        elevation: 15.0,
        backgroundColor: Colors.blueGrey.shade200,
        builder: (context) => Container(
          height: 180.0,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RawMaterialButton(
                padding: const EdgeInsets.all(20.0),
                onPressed: () {},
                elevation: 0.0,
                shape: const CircleBorder(),
                fillColor: Colors.white,
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.blueGrey,
                  size: 50,
                ),
              ),
              RawMaterialButton(
                padding: const EdgeInsets.all(20.0),
                onPressed: () {},
                elevation: 0.0,
                shape: const CircleBorder(),
                fillColor: Colors.white,
                child: const Icon(
                  Icons.photo,
                  color: Colors.blueGrey,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      );
}
