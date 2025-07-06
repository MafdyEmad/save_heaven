import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/services/web_socket.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/chat/models/chat_model.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;
  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  bool isSender = false;
  bool isSeen = false;
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back_ios),
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
                SizedBox(width: 8),
                Text(
                  widget.chat.user.name,
                  style: context.textTheme.titleLarge,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPagePadding,
                ),
                child: ListView.separated(
                  reverse: true,

                  padding: EdgeInsets.symmetric(vertical: 20),
                  itemCount: 10,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 40.h),
                    child: Column(
                      crossAxisAlignment: !isSender
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: .8.sw),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r),
                              bottomLeft: !isSender
                                  ? const Radius.circular(0)
                                  : Radius.circular(20.r),
                              bottomRight: !isSender
                                  ? Radius.circular(20.r)
                                  : const Radius.circular(0),
                            ),
                            color: isSender
                                ? AppPalette.primaryColor
                                : Colors.grey.shade100,
                          ),
                          child: Text(
                            'Hello',
                            style: context.textTheme.headlineLarge?.copyWith(
                              color: isSender ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: !isSender
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            Text(
                              formatNotificationTime(DateTime.now()),
                              style: context.textTheme.bodyLarge,
                            ),
                            SizedBox(width: 2),
                            if (isSeen && isSender)
                              const Icon(
                                Icons.remove_red_eye_rounded,
                                size: 15,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.grey.shade100,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 180),
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: IntrinsicHeight(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 6,
                            ),
                            alignment: Alignment.center,

                            child: TextField(
                              controller: messageController,
                              style: context.textTheme.headlineLarge?.copyWith(
                                color: Colors.black,
                              ),
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                              ),
                            ),
                          ),
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
                        print('asd');
                        WebSocketServices.emitEvent('SendMessage', {
                          "senderId": "6866c767ab8a10d94f8cc53d",
                          "receiverId": "6866f4235a704cb6e7a37655",
                          "message": "hiii",
                          "chatId": "6867e6ab0934f7dedb5de355",
                        });
                      },
                      icon: Icon(Icons.send_rounded, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  String formatNotificationTime(DateTime date) {
    if (_isToday(date)) {
      return DateFormat('hh:mm a').format(date);
    }
    return DateFormat('dd MMM yyy hh:mm a').format(date);
  }

  // bool _containsArabic(String text) {
  //   final arabicRegex = RegExp(r'[\u0600-\u06FF]');
  //   return arabicRegex.hasMatch(text);
  // }
}
