import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            SnackBar(content: const Text('logged_out').tr()),
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
                    'account',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ).tr(),
                  if (state.user.providerData.first.providerId == 'password')
                    ListTile(
                      leading: const Icon(Icons.mail),
                      title: const Text('email').tr(),
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
                    title: const Text('update_password').tr(),
                    dense: true,
                    onTap: () => Navigator.pushNamed(
                      context,
                      UpdatePasswordScreen.routeName,
                      arguments: state.user,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('favorites').tr(),
                    dense: true,
                    onTap: () => Navigator.pushNamed(
                      context,
                      ListScreen.routeName,
                      arguments: const ListArguments(listName: 'favorites'),
                    ),
                  ),
                  const Divider(thickness: 1.0),
                  const Text(
                    'host',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ).tr(),
                  ListTile(
                    leading: const Icon(Icons.corporate_fare),
                    title: const Text('profile').tr(),
                    dense: true,
                    onTap: () => Navigator.pushNamed(
                      context,
                      HostScreen.routeName,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.house),
                    title: const Text('my_rentals').tr(),
                    dense: true,
                    onTap: () => Navigator.pushNamed(
                      context,
                      ListScreen.routeName,
                      arguments: const ListArguments(listName: 'rentals'),
                    ),
                  ),
                  const Divider(thickness: 1.0),
                ],
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('language').tr(),
                  subtitle: Text(
                    context.locale.languageCode == 'en' ? 'English' : 'العربية',
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
              ],
            ),
            if (state is UserLoading) const LoadingWidget()
          ],
        );
      },
    );
  }
}
