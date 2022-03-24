import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/models/models.dart';
import 'widgets/carousel_indicator.dart';

class RentalDetails extends StatefulWidget {
  static const routeName = '/rental_details';

  final Rental rental;
  const RentalDetails({
    required this.rental,
    Key? key,
  }) : super(key: key);

  @override
  State<RentalDetails> createState() => _RentalDetailsState();
}

class _RentalDetailsState extends State<RentalDetails> {
  final _carouselController = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rental.title),
      ),
      // headerSliverBuilder: (context, innerBoxIsScrolled) => [
      //   SliverAppBar(
      //     title: Text(widget.rental.title),
      //     forceElevated: true,
      //     floating: true,
      //     snap: true,
      //   ),
      // ],
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 4,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: widget.rental.images.length,
                itemBuilder: (context, index, realIndex) => CachedNetworkImage(
                  imageUrl: widget.rental.images[index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0,
                    aspectRatio: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),
          ),
          CarouselIndicator(
            items: widget.rental.images,
            carouselController: _carouselController,
            current: _current,
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.rental.rentPrice} EGP / ${widget.rental.rentType.name}',
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget.rental.regionId}, ${tr('governorates.${widget.rental.governorateId}')}',
                style: TextStyle(
                  color: Colors.blueGrey.shade400,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            tr('propertyType.${widget.rental.propertyType.index}'),
            style: TextStyle(
              color: Colors.blueGrey.shade400,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            DateFormat('hh:mma d MMM, yyy')
                .format(widget.rental.createdAt!.toDate()),
          ),
          const SizedBox(height: 4.0),
          Container(
            padding: const EdgeInsets.all(4.0),
            color: Colors.blueGrey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rooms: ${widget.rental.numberOfRooms}'),
                Text('Bathrooms: ${widget.rental.numberOfBathrooms}'),
                Text(
                  'Furnished: ${widget.rental.furnished == true ? 'Yes' : 'No'}',
                ),
                Text('Floor: ${widget.rental.floorNumber}'),
                Text('Area: ${widget.rental.area} m\3'),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          const Text('Address'),
          Container(
            padding: const EdgeInsets.all(4.0),
            color: Colors.blueGrey.shade100,
            child: Text(widget.rental.address),
          ),
          const SizedBox(height: 8.0),
          const Text('Description'),
          Container(
            padding: const EdgeInsets.all(4.0),
            color: Colors.blueGrey.shade100,
            child: Text(widget.rental.description),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.call),
      ),
    );
  }
}
