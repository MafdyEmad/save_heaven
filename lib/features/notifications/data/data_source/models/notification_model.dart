class NotificationModel {
  final String id;
  final String image;
  final String name;
  final String userId;
  final String type;
  final String relatedId;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String content;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.image,
    required this.relatedId,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    required this.content,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      name: json['name'] ?? '',
      type: json['type'],
      image: json['image'] ?? '',
      id: json['_id'],
      userId: json['userId'],
      relatedId: json['relatedId'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      content: json['content'],
    );
  }
}
