class Chat {
  final String chatId;
  final LastMessage lastMessage;
  final User user;
  final int notSeenCount;
  final bool isOnline;

  Chat({
    required this.chatId,
    required this.lastMessage,
    required this.user,
    required this.notSeenCount,
    required this.isOnline,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      chatId: json['chatId'] ?? '',
      lastMessage: LastMessage.fromJson(json['lastMessage']),
      user: User.fromJson(json['user']),
      notSeenCount: json['notSeenCount'] ?? 0,
      isOnline: json['isOnline'] ?? false,
    );
  }
}

class LastMessage {
  final String id;
  final String image;
  final String text;
  final String chatId;
  final String senderId;
  final bool isSeen;
  final DateTime createdAt;
  final bool isSender;

  LastMessage({
    required this.id,
    required this.chatId,
    required this.image,
    required this.text,
    required this.senderId,
    required this.isSeen,
    required this.createdAt,
    required this.isSender,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      id: json['_id'] ?? '',
      image: json['image'] ?? '',
      text: json['text'] ?? '',
      chatId: json['chatId'] ?? '',
      senderId: json['senderId'] ?? '',
      isSeen: json['isSeen'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      isSender: json['isSender'] ?? false,
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String image;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
