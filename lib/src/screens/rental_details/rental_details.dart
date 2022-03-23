import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../data/models/models.dart';

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
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => const [
          SliverAppBar(
            title: Text('Rental'),
            forceElevated: true,
            floating: true,
            snap: true,
          ),
        ],
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: widget.rental.images.length,
                  itemBuilder: (context, index, realIndex) =>
                      CachedNetworkImage(
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
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.rental.images.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () =>
                            _carouselController.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 4.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black)
                                .withOpacity(_current == entry.key ? 1.0 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.blueGrey.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.rental.title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FloatingActionButton.small(
                    elevation: 1.0,
                    onPressed: () {},
                    child: const Icon(Icons.call),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
