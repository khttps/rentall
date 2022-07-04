import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final List items;
  final PageController controller;
  final int current;

  const PageIndicator({
    required this.controller,
    required this.items,
    required this.current,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: items.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => controller.animateToPage(
            entry.key,
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 100),
          ),
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
                  .withOpacity(current == entry.key ? 1.0 : 0.5),
            ),
          ),
        );
      }).toList(),
    );
  }
}
