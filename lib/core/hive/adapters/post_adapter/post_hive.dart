import 'package:hive/hive.dart';

part 'post_hive.g.dart';

@HiveType(typeId: 3)
class PostHive extends HiveObject {
  @HiveField(0)
  bool isFirstTime;

  PostHive({required this.isFirstTime});
}
