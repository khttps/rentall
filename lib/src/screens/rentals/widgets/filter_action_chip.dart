import 'package:flutter/material.dart';

class FilterActionChip extends StatelessWidget {
  final String label;
  final Future<void> Function(BuildContext) onPressed;
  const FilterActionChip({
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      labelPadding: const EdgeInsetsDirectional.only(end: 8.0),
      avatar: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
      ),
      label: Text(label),
      onPressed: () async => onPressed(context),
    );
  }
}
