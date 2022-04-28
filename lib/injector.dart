import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs.dart';
import 'data/repository/rental_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Blocs
  sl.registerFactory<RentalsBloc>(
      () => RentalsBloc(repository: sl(), preferences: sl()));
  sl.registerFactory<PublishBloc>(() => PublishBloc(repository: sl()));

  //! Repositories
  sl.registerLazySingleton<RentalRepository>(
    () => RentalRepositoryImpl(
      prefs: sl(),
      connectionChecker: sl(),
    ),
  );

  //! Shared Preferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  //! Internet
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );
}
