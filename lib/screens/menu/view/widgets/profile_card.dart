import 'package:flutter/material.dart';

import '../../../../widgets/widgets.dart';
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
            ImageCircleAvatar(
              radius: 32.0,
              icon: Icons.person,
            ),
            SizedBox(width: 16.0),
            Text(
              'Guest',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: const Text('Sign In / Sign Up'),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AuthScreen.routeName,
              );
            },
          ),
        ),
      ],
    );
  }
}
