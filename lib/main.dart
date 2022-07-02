import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'firebase_options.dart';
import 'blocs.dart';
import 'injector.dart' as di;
import 'router.dart' as router;
import 'theme.dart' as theme;
import 'screens.dart';

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
      ],
      child: MaterialApp(
        title: 'Rentall',
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates
          ..add(FormBuilderLocalizations.delegate),
        theme: theme.themeData,
        initialRoute: HomeScreen.routeName,
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }
}
