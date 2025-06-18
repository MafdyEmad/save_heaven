import 'package:hive/hive.dart';

part 'secure_hive.g.dart';

@HiveType(typeId: 2)
class SecureHive extends HiveObject {
  @HiveField(0)
  String userToken;
  SecureHive({required this.userToken});
}
