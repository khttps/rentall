import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rentall/bloc/load_status.dart';

import '../bloc/publish_bloc.dart';
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
  final _images = <XFile>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: NestedScrollView(
          headerSliverBuilder: (c, i) => const [
            SliverAppBar(
              snap: true,
              floating: true,
              forceElevated: true,
              title: Text('New Rental'),
            ),
          ],
          body: BlocConsumer<PublishBloc, PublishState>(
            listener: (context, state) {
              if (state.status == LoadStatus.failed) {
                _showErrorSnackbar(context, message: state.error!);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: double.infinity,
                        child: CarouselSlider.builder(
                          itemCount: 1 + _images.length,
                          itemBuilder:
                              (BuildContext context, int index, int realIndex) {
                            return ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              child: index == _images.length
                                  ? Center(
                                      child: FloatingActionButton(
                                        onPressed: () =>
                                            _showBottomSheet(context),
                                        heroTag: 'add_photo',
                                        child: const Icon(Icons.add_a_photo),
                                      ),
                                    )
                                  : Image.file(
                                      File(_images[index].path),
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
                        ),
                      ),
                      RentalForm(formKey: _formKey),
                    ],
                  ),
                  if (state.status == LoadStatus.reloading)
                    Material(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.0, 1.0),
                                blurRadius: 4.0,
                              )
                            ]),
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(width: 16.0),
                            const Text('loading').tr(),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        heroTag: 'save',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            BlocProvider.of<PublishBloc>(context).add(PublishRental(
              rental: _formKey.currentState!.value,
              images: _images,
            ));
          }
        },
      ),
    );
  }

  Future _showBottomSheet(BuildContext context) => showModalBottomSheet(
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
                  Navigator.pop(context);
                  final image = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (image != null) setState(() => _images.add(image));
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
                  final images = await _picker.pickMultiImage();
                  if (images != null) {
                    setState(() => _images.addAll(images));
                  } else {
                    _showErrorSnackbar(
                      context,
                      message: 'Failed to retrieve images.',
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
        ),
      );

  void _showErrorSnackbar(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
