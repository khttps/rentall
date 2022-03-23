import 'package:flutter/material.dart';

import '../data/models/models.dart';
import '../screens/screens.dart';

MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) {
      switch (settings.name) {
        case Home.routeName:
          return const Home();
        case RentalEdit.routeName:
          return const RentalEdit();
        case RentalDetails.routeName:
          {
            final rental = settings.arguments as Rental;
            return RentalDetails(rental: rental);
          }
        default:
          return const SizedBox.shrink();
      }
    },
  );
}
