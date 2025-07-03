class AdoptionRequestsModel {
  final String id;
  final String userId;
  final Child childId;
  final String status;
  final DateTime createdAt;

  AdoptionRequestsModel({
    required this.id,
    required this.userId,
    required this.childId,
    required this.status,
    required this.createdAt,
  });
  factory AdoptionRequestsModel.fromJson(Map<String, dynamic> json) {
    return AdoptionRequestsModel(
      id: json['_id'],
      userId: json['userId'] ?? '',
      childId: Child.fromJson(json['childId']),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class Child {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String religion;
  final String image;

  Child({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.religion,
    required this.image,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['_id'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      religion: json['religion'],
      image: json['image'],
    );
  }
}
