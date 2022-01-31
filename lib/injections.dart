import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as client;
import 'package:tvseries_app/features/auth/data/datasources/auth_local_data.dart';

import 'core/network/headers.dart';
import 'core/network/network_info.dart';
import 'features/auth/data/repository/auth_repository_imple.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/auth_use_case.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/person/data/datasources/person_remote_data.dart';
import 'features/person/data/repository/person_repository_imple.dart';
import 'features/person/domain/repository/person_repository.dart';
import 'features/person/domain/usecases/person_use_case.dart';
import 'features/person/presentation/bloc/person_bloc.dart';
import 'features/show/data/datasources/show_remote_data.dart';
import 'features/show/data/repository/show_repository_imple.dart';
import 'features/show/domain/repository/show_repository.dart';
import 'features/show/domain/usecases/show_use_case.dart';
import 'features/show/presentation/bloc/show_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //await dotenv.load(fileName: ".env");
  //await DotEnv().load('.env');
  //await dotenv.load(fileName: ".env");

  //Blocs -----------------------------------------
  sl.registerFactory(() => AuthBloc(authUseCase: sl()));
  sl.registerFactory(() => ShowBloc(showUseCase: sl()));
  sl.registerFactory(() => PersonBloc(personUseCase: sl()));

  sl.registerLazySingleton(() => AuthUseCase(sl()));
  sl.registerLazySingleton(() => ShowUseCase(sl()));
  sl.registerLazySingleton(() => PersonUseCase(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImple(localDataSource: sl()),
  );
  sl.registerLazySingleton<ShowRepository>(
    () => ShowRepositoryImple(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<PersonRepository>(
    () => PersonRepositoryImple(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<AuthLocalData>(
    () => AuthLocalDataImple(),
  );
  sl.registerLazySingleton<ShowRemoteData>(
    () => ShowRemoteDataImple(client: sl()),
  );
  sl.registerLazySingleton<PersonRemoteData>(
    () => PersonRemoteDataImple(client: sl()),
  );

  sl.registerLazySingleton(() => Headers());

  sl.registerLazySingleton<NetworkInfo>(() =>
      NetworkInfoImpl(sl(), /* dotenv.env['URL']! */ "https://api.tvmaze.com"));

  //! External
  //final sharedPreferences = await SharedPreferences.getInstance();
  //sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => client.Client());
  sl.registerLazySingleton(() => Connectivity());
}
