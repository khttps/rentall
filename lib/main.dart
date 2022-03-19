import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/injector.dart' as di;
import 'firebase_options.dart';
import 'src/screens/blocs.dart';
import 'src/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<RentalsBloc>(
          create: (context) => di.sl()..add(const GetRentals()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rentall',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: Home.routeName,
        onGenerateRoute: _onGenerateRoute,
      ),
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
