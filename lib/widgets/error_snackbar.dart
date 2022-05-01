import 'package:flutter/material.dart';

class ErrorSnackbar extends SnackBar {
  final String message;
  ErrorSnackbar({
    required this.message,
    Key? key,
  }) : super(
          backgroundColor: Colors.red,
          content: Text(
            message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          key: key,
        );
}
