import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/extensions.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

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
                      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text("Mafdy", style: context.textTheme.titleLarge),
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
                      onPressed: () {},
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
