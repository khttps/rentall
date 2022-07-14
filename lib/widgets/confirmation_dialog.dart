import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final Function() onPositive;
  const ConfirmationDialog({
    this.title,
    this.content,
    required this.onPositive,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            onPositive();
            Navigator.pop(context);
          },
          child: const Text('yes').tr(),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('no').tr(),
        )
      ],
    );
  }
}
