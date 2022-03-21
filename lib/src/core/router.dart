import 'package:flutter/material.dart';

import '../screens/screens.dart';

MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) {
      switch (settings.name) {
        case Home.routeName:
          return const Home();
        case RentalEdit.routeName:
          return const RentalEdit();
        default:
          return const SizedBox.shrink();
      }
    },
  );
}
