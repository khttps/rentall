import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
    Key? key,
    required this.items,
    required CarouselController carouselController,
    required int current,
  })  : _carouselController = carouselController,
        _current = current,
        super(key: key);

  final List items;
  final CarouselController _carouselController;
  final int _current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _carouselController.animateToPage(entry.key),
          child: Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 4.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.blueGrey)
                  .withOpacity(_current == entry.key ? 1.0 : 0.5),
            ),
          ),
        );
      }).toList(),
    );
  }
}
