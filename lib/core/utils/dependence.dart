import 'package:get_it/get_it.dart';
import 'package:save_heaven/core/caching/caching_manager.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/features/auth/data/data_scource/auth_remote_data_source.dart';
import 'package:save_heaven/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:save_heaven/features/notifications/data/data_source/notification_remote_data_source.dart';
import 'package:save_heaven/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:save_heaven/shared/features/home/data/data_source/home_remote_data_source.dart';
import 'package:save_heaven/shared/features/home/presentation/cubit/home_cubit.dart';

final getIt = GetIt.instance;

void setupDependency() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<CacheManager>(() => CacheManager());
  _setUpHome();
  _setAuth();
  _setUpNotifications();
}

void _setAuth() {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt<AuthRemoteDataSource>()));
}

void _setUpHome() {
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiService: getIt<ApiService>(), cacheManager: getIt<CacheManager>()),
  );
  getIt.registerLazySingleton<HomeCubit>(
    () => HomeCubit(homeRemoteDataSource: getIt<HomeRemoteDataSource>()),
  );
}

void _setUpNotifications() {
  getIt.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<NotificationCubit>(
    () => NotificationCubit(getIt<NotificationRemoteDataSource>()),
  );
}
