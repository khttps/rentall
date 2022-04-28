import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentall/bloc/load_status.dart';
import 'package:rentall/widgets/widgets.dart';

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
  var _currentPage = 0;

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
                ScaffoldMessenger.of(context).showSnackBar(
                  ErrorSnackbar(message: state.error!),
                );
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        width: double.infinity,
                        child: CarouselSlider.builder(
                          itemCount: 1 + _images.length,
                          itemBuilder: (context, index, _) {
                            if (index == _images.length) {
                              return Center(
                                child: FloatingActionButton(
                                  heroTag: 'add_photo',
                                  child: const Icon(Icons.add_a_photo),
                                  onPressed: () {
                                    _showBottomSheet(context);
                                  },
                                ),
                              );
                            } else {
                              return Stack(
                                alignment: Alignment.center,
                                fit: StackFit.expand,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                      child: ImageBuilder(
                                        path: _images[index].path,
                                        aspectRatio: 16 / 9,
                                      ),
                                    ),
                                  ),
                                  if (index == _currentPage)
                                    Positioned(
                                      top: 0.0,
                                      right: 0.0,
                                      child: InkWell(
                                        onTap: () => _showRemoveImageDialog(
                                            context, index),
                                        child: Container(
                                          padding: const EdgeInsets.all(2.0),
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0.0, 1.0),
                                                    blurRadius: 1.0)
                                              ]),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.blueGrey,
                                            size: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }
                          },
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                            aspectRatio: 1.0,
                            onPageChanged: (i, _) => setState(
                              () => _currentPage = i,
                            ),
                          ),
                        ),
                      ),
                      RentalForm(formKey: _formKey),
                    ],
                  ),
                  if (state.status == LoadStatus.reloading)
                    const LoadingWidget(),
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

  Future<dynamic> _showRemoveImageDialog(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove this image?'),
        actions: [
          TextButton(
            onPressed: () {
              setState(
                () => _images.removeAt(index),
              );
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          )
        ],
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
                      source: ImageSource.camera, imageQuality: 50);
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
                  final images = await _picker.pickMultiImage(imageQuality: 50);
                  if (images != null) {
                    setState(() => _images.addAll(images));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      ErrorSnackbar(message: 'Failed to retrieve images.'),
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
}
