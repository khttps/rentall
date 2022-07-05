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
      appBar: AppBar(title: const Text('Done')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          text: TextSpan(
            text: 'An email has been sent to ',
            style: const TextStyle(fontSize: 18.0, color: Colors.black87),
            children: [
              TextSpan(
                text: email,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(
                text: ' with your new password.',
              ),
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
