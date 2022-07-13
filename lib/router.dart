import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:rentall/screens/screens.dart';
import 'data/models/models.dart';

MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) {
      switch (settings.name) {
        case HomeScreen.routeName:
          return const HomeScreen();
        case PublishScreen.routeName:
          return PublishScreen(
            rental: settings.arguments as Rental?,
          );
        case UpdateEmailScreen.routeName:
          return UpdateEmailScreen(user: settings.arguments as auth.User?);
        case UpdatePasswordScreen.routeName:
          return const UpdatePasswordScreen();
        case SearchScreen.routeName:
          return const SearchScreen();
        case AuthScreen.routeName:
          return const AuthScreen();
        case ListScreen.routeName:
          return ListScreen(listName: settings.arguments as String);
        case HostScreen.routeName:
          return const HostScreen();
        case PasswordSentScreen.routeName:
          return PasswordSentScreen(email: settings.arguments as String);
        case AlertScreen.routeName:
          return AlertScreen(alert: settings.arguments as Alert?);
        case AlertsScreen.routeName:
          return const AlertsScreen();
        case AddLocationScreen.routeName:
          return const AddLocationScreen();
        case DetailsScreen.routeName:
          return DetailsScreen(
            rental: settings.arguments as Rental,
          );
        case AutofillScreen.routeName:
          return const AutofillScreen();
        default:
          return const SizedBox.shrink();
      }
    },
  );
}
