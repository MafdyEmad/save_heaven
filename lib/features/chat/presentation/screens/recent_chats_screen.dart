import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/hive/adapters/user_adapter/user_hive.dart';
import 'package:save_heaven/core/hive/hive_boxes/hive_boxes.dart';
import 'package:save_heaven/core/services/web_socket.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:save_heaven/features/chat/presentation/screens/chat_screen.dart';

class RecentChatsScreen extends StatefulWidget {
  const RecentChatsScreen({super.key});

  @override
  State<RecentChatsScreen> createState() => _RecentChatsScreenState();
}

class _RecentChatsScreenState extends State<RecentChatsScreen> {
  final bloc = getIt<ChatCubit>();
  final UserHive user = HiveBoxes.userBox.getAt(0);
  final String secure = HiveBoxes.secureBox.getAt(0);
  @override
  void initState() {
    print(user.id);
    print(secure);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WebSocketServices.emitEvent('OpenApp', {'userId': user.id});
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.horizontalPagePadding,
          ),
          child: StreamBuilder(
            stream: WebSocketServices.listenEvent('GetChats'),
            builder: (context, snapshot) {
              print(snapshot.data);
              return Column(
                children: [
                  CustomTextField(hint: 'search...'),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          context.push(const ChatScreen());
                        },

                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Row(
                            children: [
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
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Mafdy',
                                      style: context.textTheme.titleLarge,
                                    ),
                                    Text(
                                      'I am a teacher and I want to help your childrenI am a teacher and I want to help your childrenI am a teacher and I want to help your children',
                                      style: context.textTheme.headlineSmall
                                          ?.copyWith(color: Colors.grey),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
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
            },
          ),
        ),
      ),
    );
  }
}
