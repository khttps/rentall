import 'package:flutter/material.dart';

class PostAppBar extends StatelessWidget {
  final String title;
  final Function() onSave;
  const PostAppBar({
    required this.title,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      snap: true,
      floating: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.close),
      ),
      forceElevated: true,
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: () => onSave(),
        ),
      ],
    );
  }
}
