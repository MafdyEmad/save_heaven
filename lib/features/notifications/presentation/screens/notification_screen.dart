import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final bloc = getIt<NotificationCubit>();
  @override
  void initState() {
    bloc.getNotifications();
    super.initState();
  }

  final notificationStates = List.unmodifiable([
    GetNotificationsLoading,
    GetNotificationsFail,
    GetNotificationsSuccess,
  ]);
  @override
  Widget build(BuildContext context) {
    // print(HiveBoxes.secureBox.values.first);
    // print(JwtDecoder.decode(HiveBoxes.secureBox.values.first));

    return BlocProvider.value(
      value: bloc,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Notifications', style: context.textTheme.titleLarge),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPagePadding,
              ),
              child: BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  if (state is GetNotificationsLoading ||
                      state is NotificationInitial) {
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
                  if (state is GetNotificationsFail) {
                    return Center(
                      child: Text(
                        state.message,
                        style: context.textTheme.headlineLarge,
                      ),
                    );
                  }
                  final notifications =
                      (state as GetNotificationsSuccess).notifications;
                  if (notifications.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: double.infinity),
                        Icon(
                          Icons.notifications_active,
                          color: AppPalette.primaryColor,
                          size: context.width * .5,
                        ),
                        Text(
                          'Nothing to display here!',
                          style: context.textTheme.headlineLarge?.copyWith(
                            color: AppPalette.primaryColor,
                          ),
                        ),
                        Text(
                          'Likes, comments and replies will appear here!',
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: AppPalette.primaryColor,
                          ),
                        ),
                      ],
                    );
                  }
                  return ListView.separated(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!notifications[index].isRead)
                            Icon(Icons.circle, color: Colors.red, size: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${ApiEndpoints.imageProvider}${notifications[index].image}',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.person, size: 30),
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        notifications[index].name,
                        style: context.textTheme.headlineLarge,
                      ),
                      subtitle: Text(
                        notifications[index].message,
                        style: context.textTheme.bodyLarge,
                      ),
                      trailing: Text(
                        timeago.format(notifications[index].createdAt),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
