import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'src/core/injector.dart' as injector;
import 'src/core/router.dart' as router;
import 'src/core/style.dart' as style;
import 'src/screens/blocs.dart';
import 'src/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await injector.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.blueGrey),
  );
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en'), Locale('ar')],
      child: const RentallApp(),
    ),
  );
}

class RentallApp extends StatelessWidget {
  const RentallApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RentalsBloc>(
          create: (context) => injector.di()..add(const GetRentals()),
        ),
      ],
      child: MaterialApp(
        title: 'Rentall',
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        theme: style.themeData,
        initialRoute: Home.routeName,
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }
}
