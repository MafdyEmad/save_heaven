class NotificationModel {
  final String type;
  final DateTime createdAt;
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(type: json['type'] ?? '', createdAt: DateTime.parse(json['createdAt']));
  }

  NotificationModel({required this.type, required this.createdAt});
}
