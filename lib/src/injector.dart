import 'package:get_it/get_it.dart';
import 'package:rentall/src/publish/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc.dart';
import 'rentals/data/data.dart';

final di = GetIt.instance;

Future<void> init() async {
  //! Blocs
  di.registerFactory(() => RentalsBloc(repository: di(), preferences: di()));
  di.registerFactory(() => PublishBloc(repository: di()));

  //! Repositories
  di.registerLazySingleton<RentalRepository>(
    () => RentalRepositoryImpl(prefs: di()),
  );

  //! Shared Preferences
  final prefs = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => prefs);
}
