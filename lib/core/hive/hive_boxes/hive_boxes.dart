import 'package:hive/hive.dart';
import 'package:save_heaven/core/hive/hive_keys/hive_keys.dart';

class HiveBoxes {
  static final Box appConfigBox = Hive.box(HiveKeys.appConfig);
  static final Box userSettingBox = Hive.box(HiveKeys.userSetting);
  static final Box userBox = Hive.box(HiveKeys.user);
  static final Box secureBox = Hive.box(HiveKeys.secure);
  static final Box postsBox = Hive.box(HiveKeys.posts);
}
