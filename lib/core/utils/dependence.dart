import 'package:get_it/get_it.dart';
import 'package:save_heaven/core/caching/caching_manager.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/features/auth/data/data_scource/auth_remote_data_source.dart';
import 'package:save_heaven/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:save_heaven/features/chat/data/chat_remote_data_source.dart';
import 'package:save_heaven/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:save_heaven/features/donation/data/data_source/donation_remote_data_source.dart';
import 'package:save_heaven/features/donation/presentation/cubit/donation_cubit.dart';
import 'package:save_heaven/features/kids/presentation/cubit/orphanage%20cubit/orphanage_near_cubit.dart';
import 'package:save_heaven/features/kids/presentation/data_source/remote_data_source.dart';
import 'package:save_heaven/features/notifications/data/data_source/notification_remote_data_source.dart';
import 'package:save_heaven/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:save_heaven/features/orphanage_dontaion/data/data_source/orphanage_donation_remote_data_source.dart';
import 'package:save_heaven/features/orphanage_dontaion/presentation/cubit/orphanage_donation_state_cubit.dart';
import 'package:save_heaven/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:save_heaven/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:save_heaven/shared/features/home/data/data_source/home_remote_data_source.dart';
import 'package:save_heaven/shared/features/home/presentation/cubit/home_cubit.dart';

final getIt = GetIt.instance;

void setupDependency() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<CacheManager>(() => CacheManager());
  _setUpHome();
  _setAuth();
  _setUpNotifications();
  _setUpOrphanageDonation();
  _setUpProfile();
  _setChat();
  _setUpOrphanage();
  _setUpDonation();
}

void _setAuth() {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(getIt<AuthRemoteDataSource>()),
  );
}

void _setUpOrphanage() {
  getIt.registerLazySingleton<OrphanageRemoteDataSource>(
    () => OrphanageRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<OrphanageNearCubit>(
    () => OrphanageNearCubit(getIt<OrphanageRemoteDataSource>()),
  );
}

void _setUpHome() {
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      apiService: getIt<ApiService>(),
      cacheManager: getIt<CacheManager>(),
    ),
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

void _setUpOrphanageDonation() {
  getIt.registerLazySingleton<OrphanageDonationRemoteDataSource>(
    () =>
        OrphanageDonationRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<OrphanageDonationCubit>(
    () => OrphanageDonationCubit(getIt<OrphanageDonationRemoteDataSource>()),
  );
}

void _setUpProfile() {
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<ProfileCubit>(
    () => ProfileCubit(getIt<ProfileRemoteDataSource>()),
  );
}

void _setChat() {
  getIt.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ChatCubit>(
    () => ChatCubit(getIt<ChatRemoteDataSource>()),
  );
}

void _setUpDonation() {
  getIt.registerLazySingleton<DonationRemoteDataSource>(
    () => DonationRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<DonationCubit>(
    () => DonationCubit(
      getIt<DonationRemoteDataSource>(),
      getIt<OrphanageRemoteDataSource>(),
    ),
  );
}
