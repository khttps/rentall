import 'package:easy_localization/easy_localization.dart';
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
        Center(child: const Text('nothing').tr()),
      ],
    );
  }
}
