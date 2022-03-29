import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repositories/rental_repository.dart';
import '../screens/rentals/bloc/rentals_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {
  //! Blocs
  di.registerFactory(() => RentalsBloc(repository: di()));

  //! Repositories
  di.registerLazySingleton<RentalRepository>(
    () => RentalRepositoryImpl(prefs: di()),
  );

  //! Shared Preferences
  final prefs = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => prefs);
}
