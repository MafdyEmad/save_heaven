import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:save_heaven/core/hive/adapters/app_config_adapter/app_config_model.dart';
import 'package:save_heaven/core/hive/adapters/user_settings_adapter/user_setting_hive.dart';
import 'package:save_heaven/core/hive/hive_boxes/hive_boxes.dart';
import 'package:save_heaven/core/hive/hive_keys/hive_keys.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/firebase_options.dart';
import 'package:save_heaven/save_heaven.dart';
import 'package:save_heaven/core/utils/app_bloc_observer.dart';

const userToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODUxMDg4N2JiN2VhNGRkOWJmYmFkZWMiLCJpYXQiOjE3NTAxNDEyMjgsImV4cCI6MTc1NzkxNzIyOH0.sSYtalZfC1YDVxJmpHhL544yzXG334_MA00mfhqrO3c';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependency();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  Bloc.observer = AppBlocObserver();
  await ScreenUtil.ensureScreenSize();
  await _initHive();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _setupFirebaseMessaging();
  runApp(const SaveHeaven());
}

void _setupFirebaseMessaging() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.instance.requestPermission(alert: true, badge: true, sound: true, provisional: true);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('📥 Foreground FCM: ${message.data}');
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('📨 Background FCM: ${message.messageId}');
}

Future<void> _initHive() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(AppConfigModelAdapter());
  Hive.registerAdapter(UserSettingHiveAdapter());
  await Future.wait([Hive.openBox(HiveKeys.appConfig), Hive.openBox(HiveKeys.userSetting)]);

  Box appConfigBox = HiveBoxes.appConfigBox;
  if (appConfigBox.isEmpty) {
    await appConfigBox.add(AppConfigModel(isFirstTime: true));
  }
}

Future<void> loadDefaultValues() async {
  Box appConfigBox = HiveBoxes.appConfigBox;
  if (appConfigBox.isEmpty) {
    await appConfigBox.add(AppConfigModel(isFirstTime: true));
  }
}
