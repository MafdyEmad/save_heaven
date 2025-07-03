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
  final OrphanageHive? orphanage;
  @HiveField(14)
  final String? image;

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
    required this.image,
    required this.v,
    required this.orphanage,
  });
  factory UserHive.fromModel(UserModel model) {
    return UserHive(
      image: model.image,
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
      orphanage: model.orphanage == null
          ? null
          : OrphanageHive.fromModel(model.orphanage!),
    );
  }
}

@HiveType(typeId: 5)
class WorkScheduleHive {
  @HiveField(0)
  final List<String> workDays;

  @HiveField(1)
  final List<String> workHours;

  WorkScheduleHive({required this.workDays, required this.workHours});
  factory WorkScheduleHive.fromModel(WorkSchedule model) {
    return WorkScheduleHive(
      workDays: model.workDays,
      workHours: model.workHours,
    );
  }
}

@HiveType(typeId: 6)
class OrphanageHive extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String adminName;

  @HiveField(2)
  final String? image;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final bool active;

  @HiveField(5)
  final DateTime establishedDate;

  @HiveField(6)
  final String phone;

  @HiveField(7)
  final DateTime birthdate;

  @HiveField(8)
  final WorkScheduleHive workSchedule;

  OrphanageHive({
    required this.name,
    required this.adminName,
    required this.image,
    required this.address,
    required this.active,
    required this.establishedDate,
    required this.phone,
    required this.birthdate,
    required this.workSchedule,
  });

  factory OrphanageHive.fromModel(Orphanage model) {
    return OrphanageHive(
      name: model.name,
      adminName: model.adminName,
      image: model.image,
      address: model.address,
      // currentChildren: model.currentChildren,
      // totalCapacity: model.totalCapacity,
      active: model.active,
      // staffCount: model.staffCount,
      establishedDate: model.establishedDate,
      phone: model.phone,
      birthdate: model.birthdate,
      workSchedule: WorkScheduleHive.fromModel(model.workSchedule),
    );
  }
}
