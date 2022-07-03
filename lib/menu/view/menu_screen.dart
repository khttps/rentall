import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

class MenuScreen extends StatelessWidget {
  static const routeName = '/menu';
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: [
        const LoggedOutProfile(),
        const Divider(thickness: 1.0),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Profile'),
          dense: true,
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('Favorites'),
          dense: true,
          onTap: () {},
        ),
        const Divider(thickness: 1.0),
        ListTile(
          leading: const Icon(Icons.hotel),
          title: const Text('Host'),
          dense: true,
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.house),
          title: const Text('My Rentals'),
          dense: true,
          onTap: () {},
        ),
        const Divider(thickness: 1.0),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          dense: true,
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          dense: true,
          onTap: () {},
        ),
      ],
    );
  }
}
