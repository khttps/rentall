import 'package:easy_localization/easy_localization.dart';
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
    final signedIn = user != null;
    final displayName = user?.displayName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // const ImageCircleAvatar(
            //   radius: 22.0,
            //   icon: Icons.person,
            // ),
            const SizedBox(width: 16.0),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: signedIn ? tr('logged_as') : null,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text: signedIn
                          ? displayName?.isNotEmpty == true
                              ? displayName
                              : user!.email!
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
            child: Text(
              signedIn ? tr('sign_out') : '${tr('sign_in')} / ${tr('sign_up')}',
            ),
            onPressed: () {
              if (signedIn) {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmationDialog(
                    title: const Text('sign_out_title').tr(),
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
