import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/model/rental.dart';
import 'widgets/widgets.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/rental_details';

  final Rental rental;
  const DetailsScreen({
    required this.rental,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _carouselController = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final rental = widget.rental;
    final hasDescription =
        rental.description != null && rental.description!.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: Text(rental.title),
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
        children: [
          Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0.0, 1.0),
                blurRadius: 4,
              )
            ]),
            child: CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: rental.images.length,
              itemBuilder: (context, index, realIndex) => CachedNetworkImage(
                fit: BoxFit.cover,
                width: double.infinity,
                imageUrl: rental.images[index],
              ),
              options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                aspectRatio: 1.0,
                onPageChanged: (index, reason) {
                  setState(() => _current = index);
                },
              ),
            ),
          ),
          CarouselIndicator(
            items: widget.rental.images,
            carouselController: _carouselController,
            current: _current,
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${rental.rentPrice} EGP / ${rental.rentType?.name}',
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${rental.regionId}, ${tr('governorates.${rental.governorate.index}')}',
                    style: TextStyle(
                      color: Colors.blueGrey.shade400,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (rental.propertyType != null)
                Text(
                  tr('propertyType.${rental.propertyType?.index}'),
                  style: TextStyle(
                    color: Colors.blueGrey.shade400,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              Text(
                'Posted ${DateFormat('MMM d, h:mma').format(rental.createdAt!.toDate())}',
              ),
              const Divider(height: 16.0, thickness: 1.5),
              if (rental.numberOfRooms != null)
                Text('Rooms: ${rental.numberOfRooms}'),
              if (rental.numberOfBathrooms != null)
                Text('Bathrooms: ${rental.numberOfBathrooms}'),
              if (rental.furnished != null)
                Text(
                  'Furnished: ${rental.furnished == true ? 'Yes' : 'No'}',
                ),
              if (rental.floorNumber != null)
                Text('Floor: ${rental.floorNumber}'),
              RichText(
                text: TextSpan(
                  text: 'Area: ${rental.area}m\u00b3',
                  style: const TextStyle(color: Colors.black87),
                ),
              ),
              const Divider(height: 16.0, thickness: 1.5),
              const Text(
                'Address',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(rental.address),
              if (hasDescription) const Divider(height: 16.0, thickness: 1.5),
              if (hasDescription)
                const Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              Text(rental.description ?? ''),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => _launchDialer(),
        child: const Icon(Icons.call),
      ),
    );
  }

  void _launchDialer() async {
    final url = Uri.parse('tel:${widget.rental.hostPhoneNumber}');
    bool canLaunch = await canLaunchUrl(url);
    if (canLaunch) {
      await launchUrl(url);
    }
  }
}
