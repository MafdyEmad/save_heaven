class AdoptionRequestsModel {
  final String id;
  final String userId;
  final String childId;
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
      userId: json['userId'],
      childId: json['childId'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
