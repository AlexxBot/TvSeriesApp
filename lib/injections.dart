import 'package:connectivity/connectivity.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as client;

import 'core/network/headers.dart';
import 'core/network/network_info.dart';
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
  sl.registerFactory(() => ShowBloc(showUseCase: sl()));

  sl.registerLazySingleton(() => ShowUseCase(sl()));

  sl.registerLazySingleton<ShowRepository>(
    () => ShowRepositoryImple(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton<ShowRemoteData>(
    () => ShowRemoteDataImple(client: sl()),
  );

  sl.registerLazySingleton(() => Headers());

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl(), dotenv.env['URL']!));

  //! External
  //final sharedPreferences = await SharedPreferences.getInstance();
  //sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => client.Client());
  sl.registerLazySingleton(() => Connectivity());
}
