import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:save_heaven/core/hive/adapters/user_adapter/user_hive.dart';
import 'package:save_heaven/core/hive/hive_boxes/hive_boxes.dart';

class Helpers {
  static UserHive get user {
    final user = HiveBoxes.userBox.getAt(0);
    return user;
  }

  static void logout() {
    HiveBoxes.secureBox.clear();
    HiveBoxes.userBox.clear();
    FirebaseMessaging.instance.deleteToken();
  }
}
