import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/services/web_socket.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/chat/models/chat_model.dart';
import 'package:save_heaven/features/chat/models/message.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;
  final String myId;

  const ChatScreen({super.key, required this.chat, required this.myId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WebSocketServices.emitEvent('getMessages', {
      'senderId': widget.myId,
      'receiverId': widget.chat.user.id,
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    // Only do this if you want to refresh chats when leaving
    WebSocketServices.emitEvent('getChats', {'userId': widget.myId});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Chat header
            Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                SizedBox(
                  height: 65,
                  width: 65,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      ApiEndpoints.imageProvider + widget.chat.user.image,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.chat.user.name,
                  style: context.textTheme.titleLarge,
                ),
              ],
            ),

            // Chat messages
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPagePadding,
                ),
                child: StreamBuilder(
                  stream: WebSocketServices.listenEvent('GetMessages'),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    try {
                      final raw = snapshot.data;
                      if (raw is! List) {
                        throw Exception('Invalid data format');
                      }

                      final messages = raw.map<Message>((e) {
                        if (e is Map<String, dynamic>) {
                          return Message.fromJson(e);
                        } else if (e is Map) {
                          return Message.fromJson(Map<String, dynamic>.from(e));
                        } else {
                          throw Exception('Invalid message item');
                        }
                      }).toList();

                      return ListView.separated(
                        reverse: true,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemCount: messages.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final msg = messages[index];
                          final bool isSender = msg.senderId.id == widget.myId;

                          return Padding(
                            padding: EdgeInsets.only(bottom: 40.h),
                            child: Column(
                              crossAxisAlignment: isSender
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxWidth: .8.sw),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r),
                                      bottomLeft: isSender
                                          ? Radius.circular(20.r)
                                          : const Radius.circular(0),
                                      bottomRight: isSender
                                          ? const Radius.circular(0)
                                          : Radius.circular(20.r),
                                    ),
                                    color: isSender
                                        ? AppPalette.primaryColor
                                        : Colors.grey.shade100,
                                  ),
                                  child: Text(
                                    msg.message,
                                    style: context.textTheme.headlineLarge
                                        ?.copyWith(
                                          color: isSender
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: isSender
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      formatNotificationTime(msg.createdAt),
                                      style: context.textTheme.bodyLarge,
                                    ),
                                    const SizedBox(width: 2),
                                    // if (msg.isSeen && isSender)
                                    //   const Icon(
                                    //     Icons.remove_red_eye_rounded,
                                    //     size: 15,
                                    //   ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } catch (e) {
                      return Center(child: Text('Error parsing messages: $e'));
                    }
                  },
                ),
              ),
            ),

            // Message input
            Container(
              color: Colors.grey.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      style: context.textTheme.headlineLarge?.copyWith(
                        color: Colors.black,
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppPalette.primaryColor,
                      ),
                    ),
                    onPressed: () {
                      final msgText = messageController.text.trim();
                      if (msgText.isNotEmpty) {
                        WebSocketServices.emitEvent('SendMessage', {
                          "senderId": widget.myId,
                          "receiverId": widget.chat.user.id,
                          "message": msgText,
                        });
                        messageController.clear();
                      }
                    },
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  String formatNotificationTime(DateTime date) {
    if (_isToday(date)) {
      return DateFormat('hh:mm a').format(date);
    } else {
      return DateFormat('dd MMM yyyy hh:mm a').format(date);
    }
  }
}
