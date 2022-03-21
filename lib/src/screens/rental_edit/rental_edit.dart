import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                const SliverAppBar(
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
                CarouselSlider.builder(
                  itemCount: 10,
                  itemBuilder: (context, index, realIndex) =>
                      CachedNetworkImage(
                    imageUrl: 'https://i.imgur.com/ybAPITI.jpeg',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                  ),
                ),
                FormBuilderTextField(name: 'title'),
                FormBuilderTextField(
                  name: 'description',
                  minLines: 2,
                  maxLines: 2,
                ),
                FormBuilderTextField(name: 'address'),
                FormBuilderTextField(name: 'floorNumber'),
                FormBuilderTextField(name: 'numberOfRooms'),
                FormBuilderTextField(name: 'numberOfBathrooms'),
                FormBuilderDropdown(name: 'governorateId', items: []),
                FormBuilderTextField(name: 'regionId'),
                FormBuilderTextField(name: 'rentPrice'),
                FormBuilderTextField(name: 'hostPhoneNumber'),
                FormBuilderTextField(name: 'rentType'),
                FormBuilderTextField(name: 'propertyType'),
              ],
            ),
          )),
    );
  }
}
