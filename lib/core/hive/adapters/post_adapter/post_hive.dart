import 'package:hive/hive.dart';

part 'post_hive.g.dart';

@HiveType(typeId: 1)
class PostHive extends HiveObject {
  @HiveField(0)
  List<String> postIds;

  PostHive({required this.postIds});
}
