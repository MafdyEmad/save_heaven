class UserModel {
  final String id;
  final String name;
  final String gender;
  final String address;
  final String email;
  final DateTime birthdate;
  final String phone;
  final String password;
  final String role;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final Orphanage? orphanage;

  UserModel({
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
    this.orphanage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, [dynamic orphanage]) {
    return UserModel(
      id: json['_id'] ?? 0,
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      birthdate: DateTime.parse(json['birthdate'] ?? DateTime.now().toString()),
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      active: json['active'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toString()),
      v: json['__v'] ?? 0,
      orphanage: orphanage == null ? null : Orphanage.fromJson(orphanage),
    );
  }
}

class Orphanage {
  final String name;
  final String adminName;
  final String? image;
  final String address;
  final int currentChildren;
  final int totalCapacity;
  final bool active;
  final int staffCount;
  final DateTime establishedDate;
  final String phone;
  final DateTime birthdate;
  final WorkSchedule workSchedule;

  Orphanage({
    required this.name,
    required this.adminName,
    required this.image,
    required this.address,
    required this.currentChildren,
    required this.totalCapacity,
    required this.active,
    required this.staffCount,
    required this.establishedDate,
    required this.phone,
    required this.birthdate,
    required this.workSchedule,
  });

  factory Orphanage.fromJson(Map<String, dynamic> json) {
    return Orphanage(
      name: json['name'],
      adminName: json['adminName'],
      image: json['image'],
      address: json['address'],
      currentChildren: json['currentChildren'],
      totalCapacity: json['totalCapacity'],
      active: json['active'],
      staffCount: json['staffCount'],
      establishedDate: DateTime.parse(json['establishedDate']),
      phone: json['phone'],
      birthdate: DateTime.parse(json['birthdate']),
      workSchedule: WorkSchedule.fromJson(json['workSchedule']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'adminName': adminName,
      'image': image,
      'address': address,
      'currentChildren': currentChildren,
      'totalCapacity': totalCapacity,
      'active': active,
      'staffCount': staffCount,
      'establishedDate': establishedDate.toIso8601String(),
      'phone': phone,
      'birthdate': birthdate.toIso8601String(),
      'workSchedule': workSchedule.toJson(),
    };
  }
}

class WorkSchedule {
  final List<String> workDays;
  final List<String> workHours;

  WorkSchedule({required this.workDays, required this.workHours});

  factory WorkSchedule.fromJson(Map<String, dynamic> json) {
    return WorkSchedule(
      workDays: List<String>.from(json['workDays']),
      workHours: List<String>.from(json['workHours']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'workDays': workDays, 'workHours': workHours};
  }
}
