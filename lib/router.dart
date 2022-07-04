import 'package:flutter/material.dart';
import 'package:rentall/screens/screens.dart';
import 'data/models/models.dart';

MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) {
      switch (settings.name) {
        case HomeScreen.routeName:
          return const HomeScreen();
        case PublishScreen.routeName:
          return PublishScreen(
            rental: settings.arguments as Rental?,
          );
        case UpdateEmailScreen.routeName:
          return const UpdateEmailScreen();
        case UpdatePasswordScreen.routeName:
          return const UpdatePasswordScreen();
        case SearchScreen.routeName:
          return const SearchScreen();
        case AuthScreen.routeName:
          return const AuthScreen();
        case FavoritesScreen.routeName:
          return const FavoritesScreen();
        case OrganizationScreen.routeName:
          return const OrganizationScreen();
        case MyRentalsScreen.routeName:
          return const MyRentalsScreen();
        case DetailsScreen.routeName:
          return DetailsScreen(
            rental: settings.arguments as Rental,
          );
        default:
          return const SizedBox.shrink();
      }
    },
  );
}
