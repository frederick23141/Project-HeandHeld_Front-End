import 'package:get_it/get_it.dart';
import 'package:handheld_beta/features/auth/data/datasources/aut_remote_data_source.dart';
import 'package:http/http.dart' as http;

import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/verify_user_usecase.dart';
import 'presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

void initAuth() {
  // Bloc
  sl.registerFactory(() => AuthBloc(verifyUserUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => VerifyUserUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // Data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // External (HTTP Client)
  sl.registerLazySingleton(() => http.Client());
}
