import 'package:hive/hive.dart';

part 'user_setting_hive.g.dart';

@HiveType(typeId: 4)
class UserSettingHive extends HiveObject {
  @HiveField(0)
  bool isNotificationEnabled;

  UserSettingHive({required this.isNotificationEnabled});
  UserSettingHive copyWith({bool? isNotificationEnabled}) {
    return UserSettingHive(isNotificationEnabled: isNotificationEnabled ?? this.isNotificationEnabled);
  }
}
