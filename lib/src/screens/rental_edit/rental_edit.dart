import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart' as ezl;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RentalEdit extends StatefulWidget {
  static const routeName = '/rental_edit';
  const RentalEdit({Key? key}) : super(key: key);

  @override
  State<RentalEdit> createState() => _RentalEditState();
}

class _RentalEditState extends State<RentalEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        heroTag: 'save',
        child: const Icon(Icons.check),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => const [
          SliverAppBar(
            title: Text('New Rental'),
            forceElevated: true,
            floating: true,
            snap: true,
          )
        ],
        body: FormBuilder(
          key: GlobalKey<FormBuilderState>(),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: 10,
                    itemBuilder: (context, index, realIndex) =>
                        CachedNetworkImage(
                      imageUrl: 'https://i.imgur.com/ybAPITI.jpeg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      viewportFraction: 1.0,
                      aspectRatio: 16 / 10,
                    ),
                  ),
                  Positioned.directional(
                    textDirection: context.locale == const Locale('en')
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    end: 8.0,
                    bottom: 8.0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FloatingActionButton(
                          mini: true,
                          heroTag: 'camera',
                          elevation: 0.0,
                          onPressed: () {},
                          child: const Icon(Icons.add_a_photo),
                        ),
                        FloatingActionButton(
                          mini: true,
                          heroTag: 'files',
                          elevation: 0.0,
                          onPressed: () {},
                          child: const Icon(Icons.add_photo_alternate),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                children: [
                  const Text('Title'),
                  const SizedBox(height: 3.0),
                  FormBuilderTextField(
                    name: 'title',
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Property Type'),
                  const SizedBox(height: 3.0),
                  FormBuilderTextField(
                    name: 'propertyType',
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Address'),
                  const SizedBox(height: 3.0),
                  FormBuilderTextField(
                    name: 'address',
                    minLines: 3,
                    maxLines: 3,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Expanded(child: Text('Region')),
                      SizedBox(width: 8.0),
                      Expanded(child: Text('Price')),
                      SizedBox(width: 8.0),
                      Expanded(child: Text('Rent Period'))
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: FormBuilderTextField(
                          name: 'governorateId',
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Flexible(
                        child: FormBuilderTextField(
                          name: 'rentPrice',
                          decoration:
                              const InputDecoration(suffix: Text('EGP')),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Flexible(
                        child: FormBuilderTextField(
                          name: 'rentType',
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Expanded(child: Text('Number of Rooms')),
                      SizedBox(width: 8.0),
                      Expanded(child: Text('Number of Bathrooms')),
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: FormBuilderTextField(
                          name: 'numberOfRooms',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Flexible(
                        child: FormBuilderTextField(
                          name: 'numberOfBathrooms',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Expanded(child: Text('Floor Number')),
                      SizedBox(width: 8.0),
                      Expanded(child: Text('GPS Location')),
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: FormBuilderTextField(
                          name: 'floorNumber',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Flexible(
                        child: FormBuilderTextField(
                          name: 'location',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Phone'),
                  const SizedBox(height: 3.0),
                  FormBuilderTextField(
                    name: 'hostPhoneNumber',
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Description'),
                  const SizedBox(height: 3.0),
                  FormBuilderTextField(
                    name: 'description',
                    minLines: 3,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Write any other details about your rental...',
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 24.0),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
