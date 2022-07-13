import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/screens/blocs.dart';
import 'package:rentall/widgets/loading_widget.dart';
import '../../screens.dart';
import 'widgets/widgets.dart';

class MenuScreen extends StatelessWidget {
  static const routeName = '/menu';
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoggedOut) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logged out successfully.')),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(12.0),
              children: [
                ProfileCard(user: state is Authenticated ? state.user : null),
                const Divider(thickness: 1.0),
                if (state is Authenticated) ...[
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
                    subtitle: Text(state.user.email!),
                    dense: true,
                    onTap: () => Navigator.pushNamed(
                      context,
                      UpdateEmailScreen.routeName,
                      arguments: state.user,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text('Update Password'),
                    dense: true,
                    onTap: () => Navigator.pushNamed(
                      context,
                      UpdatePasswordScreen.routeName,
                      arguments: state.user,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('Favorites'),
                    dense: true,
                    onTap: () => Navigator.pushNamed(
                      context,
                      ListScreen.routeName,
                      arguments: 'Favorites',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.circle_notifications),
                    title: const Text('My Alerts'),
                    dense: true,
                    onTap: () => Navigator.pushNamed(
                      context,
                      AlertsScreen.routeName,
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
                    title: const Text('Host Profile'),
                    dense: true,
                    onTap: () => Navigator.pushNamed(
                      context,
                      HostScreen.routeName,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.house),
                    title: const Text('My Rentals'),
                    dense: true,
                    onTap: () => Navigator.pushNamed(
                        context, ListScreen.routeName,
                        arguments: 'Rentals'),
                  ),
                  const Divider(thickness: 1.0),
                ],
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  subtitle: Text(
                    context.locale.languageCode == 'en' ? 'English' : 'Arabic',
                  ),
                  dense: true,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return const LanguageDialog();
                      },
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.light_mode),
                  title: const Text('Dark Mode'),
                  subtitle: Text('Off'),
                  trailing: Switch(value: false, onChanged: (value) {}),
                  dense: true,
                ),
              ],
            ),
            if (state is UserLoading) const LoadingWidget()
          ],
        );
      },
    );
  }
}
