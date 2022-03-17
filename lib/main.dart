import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentall/src/screens/screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const RentallApp());
}

class RentallApp extends StatelessWidget {
  const RentallApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rentall',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: Home.routeName,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  MaterialPageRoute<dynamic> _onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        switch (settings.name) {
          case Home.routeName:
            return const Home();
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
