import 'package:flutter/material.dart';

class ArchiveButton extends StatelessWidget {
  final bool isArchived;
  final Function(bool) onPressed;
  const ArchiveButton({
    required this.isArchived,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(
        isArchived ? Icons.unarchive : Icons.archive,
      ),
      label: Text(isArchived ? 'Unarchive' : 'Archive'),
      style: TextButton.styleFrom(
        primary: Colors.red,
      ),
      onPressed: () {
        onPressed(isArchived);
      },
    );
  }
}
