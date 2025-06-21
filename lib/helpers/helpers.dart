import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:save_heaven/core/hive/adapters/user_adapter/user_hive.dart';
import 'package:save_heaven/core/hive/hive_boxes/hive_boxes.dart';

class Helpers {
  static UserHive get user {
    final token = HiveBoxes.secureBox.get(0);
    final id = JwtDecoder.decode(token)['userId'];
    final user = HiveBoxes.userBox.get(id);
    return user;
  }
}
