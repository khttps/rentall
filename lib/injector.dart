import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rentall/data/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/blocs.dart';
import 'data/repository/rental_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Blocs
  sl.registerFactory<RentalsBloc>(
      () => RentalsBloc(repository: sl(), preferences: sl()));
  sl.registerFactory<PublishBloc>(() => PublishBloc(repository: sl()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(repository: sl()));

  //! Repositories
  sl.registerLazySingleton<RentalRepository>(
    () => RentalRepositoryImpl(
      prefs: sl(),
      connectionChecker: sl(),
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
}
