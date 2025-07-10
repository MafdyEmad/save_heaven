import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_heaven/core/hive/adapters/user_adapter/user_hive.dart';
import 'package:save_heaven/core/services/web_socket.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/chat/models/chat_model.dart';
import 'package:save_heaven/features/chat/presentation/screens/chat_screen.dart';
import 'package:save_heaven/helpers/helpers.dart';
import 'package:shimmer/shimmer.dart';

class RecentChatsScreen extends StatefulWidget {
  const RecentChatsScreen({super.key});

  @override
  State<RecentChatsScreen> createState() => _RecentChatsScreenState();
}

class _RecentChatsScreenState extends State<RecentChatsScreen> {
  final UserHive user = Helpers.user;

  @override
  void initState() {
    WebSocketServices.connect(user.id).then((_) {
      WebSocketServices.emitEvent('getChats', {'userId': user.id});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPagePadding,
        ),
        child: Column(
          children: [
            CustomTextField(hint: 'Search...'),
            Expanded(
              child: StreamBuilder(
                stream: WebSocketServices.listenEvent('GetChats'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return _buildShimmerList();
                  }

                  final rawData = snapshot.data;

                  final chatList =
                      (rawData['Chats'] as List?)
                          ?.map((json) {
                            if (json is Map<String, dynamic>) {
                              return Chat.fromJson(json);
                            } else {
                              return null;
                            }
                          })
                          .whereType<Chat>()
                          .toList() ??
                      [];
                  if (chatList.isEmpty) {
                    return Center(
                      child: Text(
                        'No recent chats',
                        style: context.textTheme.headlineLarge,
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    itemCount: chatList.length,
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final chat = chatList[index];
                      return InkWell(
                        onTap: () {
                          context.push(ChatScreen(chat: chat, myId: user.id));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 32.5,
                                backgroundImage: NetworkImage(
                                  ApiEndpoints.imageProvider + chat.user.image,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chat.user.name,
                                      style: context.textTheme.titleLarge,
                                    ),
                                    Text(
                                      chat.lastMessage.text,
                                      style: context.textTheme.headlineLarge
                                          ?.copyWith(color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              // if (chat.notSeenCount > 0)
                              //   Container(
                              //     padding: EdgeInsets.all(4),
                              //     width: 28.w,
                              //     height: 28.w,
                              //     decoration: BoxDecoration(
                              //       color: Colors.red,
                              //       shape: BoxShape.circle,
                              //     ),
                              //     alignment: Alignment.center,
                              //     child: FittedBox(
                              //       child: Text(
                              //         getTotalUnseenMessages(chat.notSeenCount),
                              //         style: context.textTheme.headlineLarge
                              //             ?.copyWith(color: Colors.white),
                              //       ),
                              //     ),
                              //   ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.separated(
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: double.infinity,
          height: 80,
          color: Colors.white,
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 8),
      itemCount: 10,
    );
  }

  String getTotalUnseenMessages(int count) {
    if (count > 99) return '99+';
    return count.toString();
  }
}
