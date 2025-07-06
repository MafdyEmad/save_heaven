class ChildModel {
  final String id;
  final String name;
  final String gender;
  final String eyeColor;
  final String skinTone;
  final String hairColor;
  final String hairStyle;
  final String religion;
  final DateTime birthdate;
  final String image;
  final Orphanage orphanage;
  final String personality;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChildModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.eyeColor,
    required this.skinTone,
    required this.hairColor,
    required this.hairStyle,
    required this.religion,
    required this.birthdate,
    required this.image,
    required this.orphanage,
    required this.personality,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      eyeColor: json['eyeColor'] ?? '',
      skinTone: json['skinTone'] ?? '',
      hairColor: json['hairColor'] ?? '',
      hairStyle: json['hairStyle'] ?? '',
      religion: json['religion'] ?? '',
      birthdate: DateTime.parse(json['birthdate'] ?? ''),
      image: json['image'] ?? '',
      orphanage: Orphanage.fromJson(json['orphanage']),
      personality: json['personality'] as String,
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'gender': gender,
      'eyeColor': eyeColor,
      'skinTone': skinTone,
      'hairColor': hairColor,
      'hairStyle': hairStyle,
      'religion': religion,
      'birthdate': birthdate.toIso8601String(),
      'image': image,
      'orphanage': orphanage.toJson(),
      'personality': personality,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Orphanage {
  final String id;
  final String name;
  final String? image;

  Orphanage({required this.id, required this.name, this.image});

  factory Orphanage.fromJson(Map<String, dynamic> json) {
    return Orphanage(
      id: json['_id'] as String,
      name: json['name'] as String,
      image: json['image'] as String?, // can be null
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'image': image};
  }
}
