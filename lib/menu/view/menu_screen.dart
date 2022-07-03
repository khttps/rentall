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
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          dense: true,
          onTap: () {},
        ),
        const Divider(thickness: 1.0),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          dense: true,
          onTap: () {},
        ),
        const Divider(thickness: 1.0),
      ],
    );
  }
}
