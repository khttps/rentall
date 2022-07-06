import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/widgets.dart';
import '../../../blocs.dart';
import '../../../screens.dart';

class ProfileCard extends StatelessWidget {
  final User? user;
  const ProfileCard({
    this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool signedIn = user != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const ImageCircleAvatar(
              radius: 22.0,
              icon: Icons.person,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: signedIn ? 'Logged in as ' : null,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text: signedIn
                          ? user!.displayName ?? user!.email!
                          : 'Guest',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            child: Text(signedIn ? 'Sign Out' : 'Sign In / Sign Up'),
            onPressed: () {
              if (signedIn) {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmationDialog(
                    title: const Text('Are you sure you want to sign out?'),
                    onPositive: () {
                      BlocProvider.of<UserBloc>(context).add(
                        const UserSignOut(),
                      );
                    },
                  ),
                );
              } else {
                Navigator.pushNamed(
                  context,
                  AuthScreen.routeName,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
