import 'package:flutter/material.dart';
import 'rentals/model/rental.dart';
import 'screens.dart';

MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) {
      switch (settings.name) {
        case HomeScreen.routeName:
          return const HomeScreen();
        case PublishScreen.routeName:
          return const PublishScreen();
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
