import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/notifications/presentation/screens/notification_screen.dart';

PreferredSizeWidget navScreenAppBar(
  BuildContext context,

  ValueListenableBuilder valueListenableBuilder,
) {
  return AppBar(
    title: valueListenableBuilder,
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {
          context.push(const NotificationScreen());
        },
        icon: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.notifications, size: 35),
            Positioned(
              top: 5,
              right: 5,
              child: Icon(Icons.circle, color: Colors.red, size: 10),
            ),
          ],
        ),
      ),
    ],
    leading: Builder(
      builder: (context) => IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
  );
}
