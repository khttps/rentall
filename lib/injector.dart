import 'package:algolia/algolia.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rentall/data/repository/user_repository.dart';
import 'package:rentall/screens/favorites/bloc/favorites_bloc.dart';
import 'package:rentall/screens/update_email/bloc/update_email_bloc.dart';
import 'package:rentall/screens/update_password/bloc/update_password_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/blocs.dart';
import 'data/repository/rental_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Blocs
  sl.registerFactory<RentalsBloc>(
    () => RentalsBloc(
      repository: sl(),
      preferences: sl(),
    ),
  );
  sl.registerFactory<PublishBloc>(() => PublishBloc(repository: sl()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(repository: sl()));
  sl.registerFactory<UserBloc>(() => UserBloc(repository: sl()));
  sl.registerFactory<UpdateEmailBloc>(() => UpdateEmailBloc(repository: sl()));
  sl.registerFactory<UpdatePasswordBloc>(
    () => UpdatePasswordBloc(
      repository: sl(),
    ),
  );
  sl.registerFactory<FavouritesBloc>(() => FavouritesBloc(repository: sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(repository: sl()));
  sl.registerFactory<SearchBloc>(() => SearchBloc(repository: sl()));

  //! Repositories
  sl.registerLazySingleton<RentalRepository>(
    () => RentalRepositoryImpl(
      prefs: sl(),
      connectionChecker: sl(),
      algolia: sl(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(),
  );

  //! Shared Preferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  //! Internet
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );

  //! Algolia
  sl.registerLazySingleton<Algolia>(
    () => const Algolia.init(
      applicationId: 'UY78MOQ8S4',
      apiKey: '616fe45d45643c216fbaa6d5a58dfa74',
    ),
  );
}
