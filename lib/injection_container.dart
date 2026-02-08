import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'core/interceptor/app_dio.dart';
import 'core/services/cache_services.dart';
import 'features/auth/data/remote_repo/auth_remote_src.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';


final locator = GetIt.instance;

void setupLocator() {
  // Core Services - Register these first as they are dependencies for others
  locator.registerLazySingleton<Dio>(() => Api().dio);
  locator.registerLazySingleton<CacheService>(() => CacheService());
  locator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Remote Sources - Register after core services
  locator.registerLazySingleton<AuthRemoteSrc>(
    () => AuthRemoteSrc(dio: locator()),
  );

  // Blocs - Register last as they depend on remote sources
  locator.registerFactory<AuthBloc>(
    () => AuthBloc(
      authRemoteSrc: locator(),
      cacheService: locator(),
    ),
  );
}
