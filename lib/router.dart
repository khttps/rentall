import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'screens/screens.dart';
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
          return UpdatePasswordScreen(user: settings.arguments as auth.User);
        case SearchScreen.routeName:
          return const SearchScreen();
        case AuthScreen.routeName:
          return const AuthScreen();
        case ListScreen.routeName:
          return ListScreen(args: settings.arguments as ListArguments);
        case HostScreen.routeName:
          return const HostScreen();
        case PasswordSentScreen.routeName:
          return PasswordSentScreen(email: settings.arguments as String);
        case AddLocationScreen.routeName:
          return AddLocationScreen(
            initialPosition: settings.arguments as LatLng?,
          );
        case DetailsScreen.routeName:
          return DetailsScreen(
            rental: settings.arguments as Rental,
          );
        case AutofillScreen.routeName:
          return const AutofillScreen();
        case MapScreen.routeName:
          return const MapScreen();
        case VerifyEmailScreen.routeName:
          return VerifyEmailScreen(first: settings.arguments as bool);
        default:
          return const SizedBox.shrink();
      }
    },
  );
}
