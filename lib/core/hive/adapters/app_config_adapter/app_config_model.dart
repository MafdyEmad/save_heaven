import 'package:hive/hive.dart';

part 'app_config_model.g.dart';

@HiveType(typeId: 0)
class AppConfigModel extends HiveObject {
  @HiveField(0)
  bool isFirstTime;

  AppConfigModel({required this.isFirstTime});
}
