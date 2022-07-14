import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PasswordSentScreen extends StatelessWidget {
  static const routeName = '/password_sent';
  final String email;
  const PasswordSentScreen({
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('done').tr()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          text: TextSpan(
            text: tr('email_sent'),
            style: const TextStyle(fontSize: 18.0, color: Colors.black87),
            children: [
              TextSpan(
                text: email,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: tr('with_new')),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
