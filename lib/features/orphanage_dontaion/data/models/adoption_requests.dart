import 'package:save_heaven/features/profile/data/models/child_model.dart';

class AdoptionRequestsModel {
  final String id;
  final User user; // nested User object
  final ChildModel child; // nested Child object with more fields
  final String status;
  final DateTime createdAt;
  final String orphanage;
  final String reason;
  final String phone;
  final String location;
  final int monthlyIncome;
  final String occupation;
  final String religion;
  final String maritalStatus;
  final DateTime updatedAt;

  AdoptionRequestsModel({
    required this.id,
    required this.user,
    required this.child,
    required this.status,
    required this.createdAt,
    required this.orphanage,
    required this.reason,
    required this.phone,
    required this.location,
    required this.monthlyIncome,
    required this.occupation,
    required this.religion,
    required this.maritalStatus,
    required this.updatedAt,
  });

  factory AdoptionRequestsModel.fromJson(Map<String, dynamic> json) {
    return AdoptionRequestsModel(
      id: json['_id'] as String,
      user: User.fromJson(json['userId'] as Map<String, dynamic>),
      child: ChildModel.fromJson(json['childId'] as Map<String, dynamic>),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      orphanage: json['orphanage'] as String,
      reason: json['reason'] as String,
      phone: json['phone'] as String,
      location: json['location'] as String,
      monthlyIncome: json['monthlyIncome'] as int,
      occupation: json['occupation'] as String,
      religion: json['religion'] as String,
      maritalStatus: json['maritalStatus'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

class User {
  final String id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['_id'] as String, name: json['name'] as String);
  }
}
