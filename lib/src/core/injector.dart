import 'package:get_it/get_it.dart';

import '../data/repositories/rental_repository.dart';
import '../screens/rentals/bloc/rentals_bloc.dart';

final sl = GetIt.instance;

void init() {
  //! Blocs
  sl.registerFactory(() => RentalsBloc(repository: sl()));

  //! Repositories
  sl.registerLazySingleton<RentalRepository>(() => RentalRepositoryImpl());
}
