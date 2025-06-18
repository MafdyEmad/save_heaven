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
  final dynamic orphanage;

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
      id: json['_id'],
      name: json['name'],
      gender: json['gender'],
      address: json['address'],
      email: json['email'],
      birthdate: DateTime.parse(json['birthdate']),
      phone: json['phone'],
      password: json['password'],
      role: json['role'],
      active: json['active'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      orphanage: orphanage,
    );
  }
}
