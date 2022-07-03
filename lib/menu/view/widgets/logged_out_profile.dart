import 'package:flutter/material.dart';

import '../../../screens.dart';

class LoggedOutProfile extends StatelessWidget {
  const LoggedOutProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.account_circle),
            SizedBox(width: 8.0),
            Text(
              'Guest',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Get to be a part of the community, save your favorite ads, post ads of your own',
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AuthScreen.routeName);
            },
            child: const Text('Sign In / Sign Up'),
          ),
        ),
      ],
    );
  }
}
