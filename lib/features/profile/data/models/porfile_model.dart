import 'package:save_heaven/shared/features/home/data/models/post_response.dart';

class UserDataResponse {
  final User user;
  final List<Post> posts;
  final About about;

  UserDataResponse({
    required this.user,
    required this.posts,
    required this.about,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) {
    return UserDataResponse(
      user: User.fromJson(json['user']),
      posts: List<Post>.from(json['posts'].map((x) => Post.fromJson(x))),
      about: json['about'] == null
          ? About(
              phone: 'phone',
              workDays: [],
              workHours: [],
              establishedDate: DateTime.now(),
            )
          : About.fromJson(json['about']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'posts': posts.map((x) => x.toJson()).toList(),
    };
  }
}

class User {
  final String id;
  final String name;
  final String address;
  final String email;
  final DateTime birthdate;
  final String phone;
  final String image;
  final String role;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String orphanage;

  User({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.birthdate,
    required this.phone,
    required this.image,
    required this.role,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.orphanage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
      email: json['email'],
      birthdate: DateTime.parse(json['birthdate']),
      phone: json['phone'],
      image: json['image'] ?? '',
      role: json['role'],
      active: json['active'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      orphanage: json['orphanage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'address': address,
      'email': email,
      'birthdate': birthdate.toIso8601String(),
      'phone': phone,
      'image': image,
      'role': role,
      'active': active,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'orphanage': orphanage,
    };
  }
}

class About {
  final String phone;
  final List<String> workDays;
  final List<String> workHours;
  final DateTime establishedDate;

  About({
    required this.phone,
    required this.workDays,
    required this.workHours,
    required this.establishedDate,
  });

  factory About.fromJson(Map<String, dynamic> json) {
    return About(
      phone: json['phone'] as String,
      workDays: List<String>.from(json['workDays']),
      workHours: List<String>.from(json['workHours']),
      establishedDate: DateTime.parse(json['establishedDate']),
    );
  }
}
