import 'package:flutter/material.dart';

import '../../../screens.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(
              Icons.account_circle,
              size: 100.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Guest',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ],
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
