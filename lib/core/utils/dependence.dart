import 'package:get_it/get_it.dart';
import 'package:save_heaven/core/caching/caching_manager.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/shared/features/home/data/data_source/home_remote_data_source.dart';
import 'package:save_heaven/shared/features/home/presentation/cubit/home_cubit.dart';

final getIt = GetIt.instance;

void setupDependency() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<CacheManager>(() => CacheManager());
  _setUpHome();
}

void _setUpHome() {
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiService: getIt<ApiService>(), cacheManager: getIt<CacheManager>()),
  );
  getIt.registerLazySingleton<HomeCubit>(
    () => HomeCubit(homeRemoteDataSource: getIt<HomeRemoteDataSource>()),
  );
}
