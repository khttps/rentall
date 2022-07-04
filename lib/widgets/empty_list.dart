import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(),
        const Center(child: Text('Nothing to see here.')),
      ],
    );
  }
}
