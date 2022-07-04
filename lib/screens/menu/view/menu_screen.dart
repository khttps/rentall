import 'package:flutter/material.dart';
import '../../screens.dart';
import 'widgets/widgets.dart';

class MenuScreen extends StatelessWidget {
  static const routeName = '/menu';
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      children: [
        const ProfileCard(),
        const Divider(thickness: 1.0),
        const Text(
          'Account',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.mail),
          title: const Text('Email'),
          subtitle: Text('example@example.com'),
          dense: true,
          onTap: () =>
              Navigator.pushNamed(context, UpdateEmailScreen.routeName),
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Update Password'),
          dense: true,
          onTap: () =>
              Navigator.pushNamed(context, UpdatePasswordScreen.routeName),
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('Favorites'),
          dense: true,
          onTap: () => Navigator.pushNamed(
            context,
            FavoritesScreen.routeName,
          ),
        ),
        const Divider(thickness: 1.0),
        const Text(
          'Host Settings',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.corporate_fare),
          title: const Text('Organization'),
          dense: true,
          onTap: () => Navigator.pushNamed(
            context,
            OrganizationScreen.routeName,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.house),
          title: const Text('My Rentals'),
          dense: true,
          onTap: () => Navigator.pushNamed(
            context,
            MyRentalsScreen.routeName,
          ),
        ),
        const Divider(thickness: 1.0),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Language'),
          subtitle: Text('English'),
          dense: true,
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.light_mode),
          title: const Text('Dark Mode'),
          subtitle: Text('Off'),
          trailing: Switch(value: false, onChanged: (value) {}),
          dense: true,
          onTap: () {},
        ),
      ],
    );
  }
}
