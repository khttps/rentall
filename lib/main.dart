import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rentall/screens/favorites/bloc/favorites_bloc.dart';
import 'package:rentall/screens/update_email/bloc/update_email_bloc.dart';
import 'package:rentall/screens/update_password/bloc/update_password_bloc.dart';
import 'firebase_options.dart';
import 'screens/blocs.dart';
import 'injector.dart' as di;
import 'router.dart' as router;
import 'theme.dart' as theme;
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
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
          create: (context) => di.sl()..add(const GetRentals()),
        ),
        BlocProvider<PublishBloc>(create: (context) => di.sl()),
        BlocProvider<AuthBloc>(create: (context) => di.sl()),
        BlocProvider<UpdateEmailBloc>(create: (context) => di.sl()),
        BlocProvider<UpdatePasswordBloc>(create: (context) => di.sl()),
        BlocProvider<UserBloc>(create: (context) => di.sl()),
        BlocProvider<HomeBloc>(create: (context) => di.sl()),
        BlocProvider<SearchBloc>(create: (context) => di.sl()),
        BlocProvider<FavouritesBloc>(
            create: (context) => di.sl()..add(const LoadFavorites())),
      ],
      child: MaterialApp(
        title: 'Rentall',
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates
          ..add(FormBuilderLocalizations.delegate),
        theme: theme.themeData,
        home: const HomeScreen(),
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }
}
