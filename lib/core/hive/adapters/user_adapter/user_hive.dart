import 'package:hive/hive.dart';
import 'package:save_heaven/features/auth/data/models/user_model.dart';

part 'user_hive.g.dart';

@HiveType(typeId: 3)
class UserHive extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String gender;
  @HiveField(3)
  final String address;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final DateTime birthdate;
  @HiveField(6)
  final String phone;
  @HiveField(7)
  final String password;
  @HiveField(8)
  final String role;
  @HiveField(9)
  final bool active;
  @HiveField(10)
  final DateTime createdAt;
  @HiveField(11)
  final DateTime updatedAt;
  @HiveField(12)
  final int v;
  @HiveField(13)
  final dynamic orphanage;

  UserHive({
    required this.id,
    required this.name,
    required this.gender,
    required this.address,
    required this.email,
    required this.birthdate,
    required this.phone,
    required this.password,
    required this.role,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.orphanage,
  });
  factory UserHive.fromModel(UserModel model) {
    return UserHive(
      id: model.id,
      name: model.name,
      gender: model.gender,
      address: model.address,
      email: model.email,
      birthdate: model.birthdate,
      phone: model.phone,
      password: model.password,
      role: model.role,
      active: model.active,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      v: model.v,
      orphanage: model.orphanage,
    );
  }
}
