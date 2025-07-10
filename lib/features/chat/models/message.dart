class User {
  final String id;
  final String name;
  final String image;

  User({required this.id, required this.name, required this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }
}

class Message {
  final String id;
  final String chatId;
  final User senderId;
  final User receiverId;
  final String message;
  final bool isSeen;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.isSeen,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'] as String,
      chatId: json['chatId'] as String,
      senderId: User.fromJson(json['senderId']),
      receiverId: User.fromJson(json['receiverId']),
      message: json['message'] as String,
      isSeen: json['isSeen'] as bool,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
