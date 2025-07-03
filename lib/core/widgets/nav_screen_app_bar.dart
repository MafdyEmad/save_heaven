import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:save_heaven/features/notifications/presentation/screens/notification_screen.dart';

PreferredSizeWidget navScreenAppBar(
  BuildContext context,
  ValueListenableBuilder valueListenableBuilder,
  NotificationCubit notificationCubit,
  Function onDrawerOpen,
) {
  final states = List.unmodifiable([
    GetUnReadNotificationsCountLoading,
    GetUnReadNotificationsCountSuccess,
    GetUnReadNotificationsCountFail,
  ]);
  return AppBar(
    title: valueListenableBuilder,
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {
          context.push(const NotificationScreen());
        },
        icon: BlocProvider.value(
          value: notificationCubit,
          child: BlocBuilder<NotificationCubit, NotificationState>(
            buildWhen: (previous, current) =>
                states.contains(current.runtimeType),
            builder: (context, state) => Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.notifications, size: 35),
                if (state is GetUnReadNotificationsCountSuccess &&
                    state.count > 0)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Icon(Icons.circle, color: Colors.red, size: 10),
                  ),
              ],
            ),
          ),
        ),
      ),
    ],
    leading: Builder(
      builder: (context) => IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
          onDrawerOpen();
        },
      ),
    ),
  );
}
