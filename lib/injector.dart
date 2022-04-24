import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs.dart';
import 'data/repository/rental_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Blocs
  sl.registerFactory(() => RentalsBloc(repository: sl(), preferences: sl()));
  sl.registerFactory(() => PublishBloc(repository: sl()));

  //! Repositories
  sl.registerLazySingleton<RentalRepository>(
    () => RentalRepositoryImpl(prefs: sl()),
  );

  //! Shared Preferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
}
