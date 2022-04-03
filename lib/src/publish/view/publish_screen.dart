import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../bloc/bloc.dart';
import 'widgets/widgets.dart';

class PublishScreen extends StatefulWidget {
  static const routeName = '/rental_edit';
  const PublishScreen({Key? key}) : super(key: key);

  @override
  State<PublishScreen> createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  final _picker = ImagePicker();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<PublishBloc>(
      builder: (context, bloc, _) {
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
                  width: double.infinity,
                  child: StreamBuilder<List<XFile?>>(
                      stream: bloc.images,
                      builder: (context, snapshot) {
                        final images = snapshot.data;
                        final length = images?.length ?? 0;
                        return CarouselSlider.builder(
                          itemCount: 1 + length,
                          itemBuilder:
                              (BuildContext context, int index, int realIndex) {
                            return ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              child: index == length
                                  ? Center(
                                      child: FloatingActionButton(
                                        onPressed: () =>
                                            _showBottomSheet(context, bloc),
                                        heroTag: 'add_photo',
                                        child: const Icon(Icons.add_a_photo),
                                      ),
                                    )
                                  : Image.file(
                                      File(images![index]!.path),
                                      fit: BoxFit.cover,
                                    ),
                            );
                          },
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            aspectRatio: 1.0,
                            viewportFraction: 0.7,
                          ),
                        );
                      }),
                ),
                RentalForm(formKey: _formKey),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.check),
            heroTag: 'save',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print(_formKey.currentState!.value);
                bloc.add(PublishRental(rental: _formKey.currentState!.value));
              }
            },
          ),
        );
      },
    );
  }

  Future _showBottomSheet(BuildContext context, PublishBloc bloc) =>
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          height: 180.0,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RawMaterialButton(
                padding: const EdgeInsets.all(20.0),
                onPressed: () async {
                  bloc.add(
                    AddImages(
                      images: [
                        await _picker.pickImage(source: ImageSource.camera),
                      ],
                    ),
                  );
                  Navigator.pop(context);
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
                  final images = await _picker.pickMultiImage();
                  if (images != null) bloc.add(AddImages(images: images));
                  Navigator.pop(context);
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
        ),
      );
}
