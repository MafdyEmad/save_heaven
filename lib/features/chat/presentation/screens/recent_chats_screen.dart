import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_heaven/core/hive/adapters/user_adapter/user_hive.dart';
import 'package:save_heaven/core/services/web_socket.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:save_heaven/features/chat/presentation/screens/chat_screen.dart';
import 'package:save_heaven/helpers/helpers.dart';
import 'package:shimmer/shimmer.dart';

class RecentChatsScreen extends StatefulWidget {
  const RecentChatsScreen({super.key});

  @override
  State<RecentChatsScreen> createState() => _RecentChatsScreenState();
}

class _RecentChatsScreenState extends State<RecentChatsScreen> {
  final bloc = getIt<ChatCubit>();
  final UserHive user = Helpers.user;
  @override
  void initState() {
    WebSocketServices.emitEvent('OpenApp', {'userId': user.id});
    bloc.getChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.horizontalPagePadding,
          ),
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is GetChatsLoading || state is ChatInitial) {
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
              if (state is GetChatsFail) {
                return Center(
                  child: Text(
                    state.message,
                    style: context.textTheme.headlineLarge,
                  ),
                );
              }
              if (state is GetChatsSuccess) {
                if (state.chats.isEmpty) {
                  return Center(
                    child: Text(
                      'No recent chats',
                      style: context.textTheme.headlineLarge,
                    ),
                  );
                }
                final chats = state.chats;
                return Column(
                  children: [
                    CustomTextField(hint: 'search...'),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        itemCount: chats.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            context.push(ChatScreen(chat: chats[index]));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 65,
                                  width: 65,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey.shade300,
                                    backgroundImage: NetworkImage(
                                      ApiEndpoints.imageProvider +
                                          chats[index].user.image,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        chats[index].user.name,
                                        style: context.textTheme.titleLarge,
                                      ),
                                      Text(
                                        chats[index].lastMessage.text,
                                        style: context.textTheme.headlineSmall
                                            ?.copyWith(color: Colors.grey),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  width: 28.w,
                                  height: 28.w,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: FittedBox(
                                    child: Text(
                                      getTotalUnseenMessages(
                                        chats[index].notSeenCount,
                                      ),
                                      style: context.textTheme.headlineLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  String getTotalUnseenMessages(int count) {
    if (count > 99) {
      return '99+';
    }
    return count.toString();
  }
}
