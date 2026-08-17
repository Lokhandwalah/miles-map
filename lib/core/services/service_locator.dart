import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../features/auth/data/repos/auth_repository_impl.dart';
import '../../features/auth/domain/repos/auth_repository.dart';
import '../../features/auth/domain/usecases/continue_as_guest_usecase.dart';
import '../../features/auth/domain/usecases/continue_with_google_usecase.dart';
import '../../features/auth/domain/usecases/request_otp_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../network/dio_client.dart';

/// App-wide service locator.
///
/// NOTE: this is a from-scratch, minimal `get_it` setup — there was no DI
/// wiring anywhere in the app before the auth feature needed one. Scoped
/// to exactly what auth needs (a shared `Dio` client + the auth
/// feature's datasource/repo/usecases/bloc); extend it here as more
/// features need real dependencies instead of duplicating a locator per
/// feature.
final GetIt sl = GetIt.instance;

/// Registers every dependency the app currently needs. Call once from
/// `main()` before `runApp`.
Future<void> setupServiceLocator() async {
  // Core
  sl.registerLazySingleton(createDioClient);

  // Auth feature
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => RequestOtpUseCase(sl()));
  sl.registerLazySingleton(() => ContinueWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => ContinueAsGuestUseCase(sl()));
  sl.registerFactory(
    () => AuthBloc(
      requestOtpUseCase: sl(),
      continueWithGoogleUseCase: sl(),
      continueAsGuestUseCase: sl(),
    ),
  );
}
