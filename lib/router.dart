import 'package:flutter/material.dart';
import 'details/details.dart';
import 'home/home.dart';
import 'publish/publish.dart';
import 'data/model/rental.dart';

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
