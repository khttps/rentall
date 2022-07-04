import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/model/rental.dart';
import '../../screens.dart';
import 'widgets/widgets.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/details';

  final Rental rental;
  const DetailsScreen({required this.rental, Key? key}) : super(key: key);

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.black,
                Colors.transparent,
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            (rental.images.isNotEmpty)
                ? CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: rental.images.length,
                    itemBuilder: (context, index, realIndex) => Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        imageUrl: rental.images[index],
                        placeholder: (c, _) => Container(
                          color: Colors.white,
                          child: const Center(
                              child: CircularProgressIndicator.adaptive()),
                        ),
                      ),
                    ),
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      viewportFraction: 1.0,
                      aspectRatio: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() => _current = index);
                      },
                    ),
                  )
                : const SizedBox(height: 10.0),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              children: [
                CarouselIndicator(
                  items: widget.rental.images,
                  carouselController: _carouselController,
                  current: _current,
                ),
                Text(
                  rental.title,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${rental.price} EGP / ${rental.rentPeriod?.name}',
                      style: const TextStyle(fontSize: 22.0),
                    ),
                    Text(
                      '${rental.region}, ${tr('governorates.${rental.governorate.index}')}',
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
                const Divider(thickness: 1),
                if (rental.rooms != null) Text('Rooms: ${rental.rooms}'),
                if (rental.bathrooms != null)
                  Text('Bathrooms: ${rental.bathrooms}'),
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
                const Divider(thickness: 1),
                const Text(
                  'Address',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(rental.address),
                if (hasDescription) const Divider(thickness: 1),
                if (hasDescription)
                  const Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                Text(rental.description ?? ''),
                TextButton(
                  child: const Text('Update'),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      PublishScreen.routeName,
                      arguments: rental,
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => _launchDialer(),
        child: const Icon(Icons.call),
      ),
    );
  }

  void _launchDialer() async {
    final url = Uri.parse('tel:${widget.rental.hostPhone}');
    bool canLaunch = await canLaunchUrl(url);
    if (canLaunch) {
      await launchUrl(url);
    }
  }
}
