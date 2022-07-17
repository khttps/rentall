import 'package:algolia/algolia.dart';
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
    () => RentalsBloc(
      repository: sl(),
      preferences: sl(),
    ),
  );
  sl.registerFactory<PublishBloc>(() => PublishBloc(
        repository: sl(),
        userRepository: sl(),
      ));
  sl.registerFactory<AuthBloc>(() => AuthBloc(repository: sl()));
  sl.registerFactory<UserBloc>(() => UserBloc(repository: sl()));
  sl.registerFactory<UpdateEmailBloc>(() => UpdateEmailBloc(repository: sl()));
  sl.registerFactory<UpdatePasswordBloc>(
    () => UpdatePasswordBloc(
      repository: sl(),
    ),
  );
  sl.registerFactory<ListBloc>(() => ListBloc(repository: sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(repository: sl()));
  sl.registerFactory<SearchBloc>(() => SearchBloc(repository: sl()));
  sl.registerFactory<DetailsBloc>(
    () => DetailsBloc(userRepository: sl(), rentalRepository: sl()),
  );
  sl.registerFactory<HostBloc>(() => HostBloc(repository: sl()));
  sl.registerFactory<VerifyEmailCubit>(
    () => VerifyEmailCubit(repository: sl()),
  );
  sl.registerFactory<OwnerCubit>(
    () => OwnerCubit(repository: sl()),
  );

  //! Repositories
  sl.registerLazySingleton<RentalRepository>(
    () => RentalRepositoryImpl(
      connectionChecker: sl(),
      algolia: sl(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(connectionChecker: sl()),
  );

  //! Internet
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );

  //! Shared Preferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  //! Algolia
  sl.registerLazySingleton<Algolia>(
    () => const Algolia.init(
      applicationId: 'UY78MOQ8S4',
      apiKey: '616fe45d45643c216fbaa6d5a58dfa74',
    ),
  );
}
