import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/config/assets_manager.dart';
import 'package:save_heaven/core/hive/adapters/user_adapter/user_hive.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/assets_images.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/widgets/nav_screen_app_bar.dart';
import 'package:save_heaven/features/auth/presentation/views/login_view.dart';
import 'package:save_heaven/features/chat/presentation/screens/recent_chats_screen.dart';
import 'package:save_heaven/features/donation/presentation/pages/donation_home_page.dart';
import 'package:save_heaven/features/kids/presentation/pages/kids_home_view.dart';
import 'package:save_heaven/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:save_heaven/features/profile/presentation/screens/profile_screen.dart';
import 'package:save_heaven/helpers/helpers.dart';
import 'package:save_heaven/screens/saved_posts_screen.dart';
import 'package:save_heaven/shared/features/home/presentation/screens/home_screen.dart';

class DonorNavScreen extends StatefulWidget {
  const DonorNavScreen({super.key});

  @override
  State<DonorNavScreen> createState() => _DonorNavScreenState();
}

class _DonorNavScreenState extends State<DonorNavScreen> {
  final ValueNotifier screenIndex = ValueNotifier(0);
  final screens = List.unmodifiable([
    HomeScreen(),
    KidsHomeView(),
    RecentChatsScreen(),
    ProfileScreen(),
  ]);
  late final ValueNotifier<bool> isNotificationEnabled;
  UserHive user = Helpers.user;

  @override
  void initState() {
    super.initState();
    notificationCubit = getIt<NotificationCubit>()
      ..getUnreadNotificationsCount();
    isNotificationEnabled = ValueNotifier(
      FirebaseMessaging.instance.isAutoInitEnabled,
    );
  }

  late final NotificationCubit notificationCubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navScreenAppBar(
        context,

        ValueListenableBuilder(
          valueListenable: screenIndex,
          builder: (context, index, child) => Text(switch (index) {
            0 => 'Home',
            1 => 'orphanages',
            2 => 'Chats',
            3 => 'Profile',
            _ => '',
          }, style: context.textTheme.titleLarge),
        ),
        notificationCubit,
        () {
          user = Helpers.user;
          setState(() {});
        },
        true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppPalette.primaryColor,
        onPressed: () {
          context.push(DonationHomePage());
        },
        shape: CircleBorder(),
        child: SvgPicture.asset(AssetsImages.donate, width: 25),
        //  Icon(Icons.add, color: Colors.white),
      ),
      drawer: buildDrawer(),
      bottomNavigationBar: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _BottomAppBarBorderPainter(
                color: Color(0xffd8dadd),
                strokeWidth: 1,
                notchMargin: 10,
              ),
            ),
          ),
          BottomAppBar(
            shape: const CircularNotchedRectangle(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            color: Colors.transparent,
            notchMargin: 10,
            child: ValueListenableBuilder(
              valueListenable: screenIndex,
              builder: (context, index, child) => Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: index == 0
                          ? AppPalette.primaryColor
                          : Color(0xffd8dadd),
                      size: 25,
                    ),
                    onPressed: () => changeScreen(0),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      AssetsImages.people,
                      width: 25,
                      colorFilter: ColorFilter.mode(
                        index == 1
                            ? AppPalette.primaryColor
                            : Color(0xffd8dadd),
                        BlendMode.srcIn,
                      ),
                    ),

                    onPressed: () => changeScreen(1),
                  ),
                  SizedBox(width: 35),
                  IconButton(
                    icon: Icon(
                      Icons.chat,
                      size: 25,
                      color: index == 2
                          ? AppPalette.primaryColor
                          : Color(0xffd8dadd),
                    ),
                    onPressed: () => changeScreen(2),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      size: 25,
                      color: index == 3
                          ? AppPalette.primaryColor
                          : Color(0xffd8dadd),
                    ),
                    onPressed: () => changeScreen(3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: screenIndex,
        builder: (context, value, child) => screens[value],
      ),
    );
  }

  void changeScreen(int index) {
    screenIndex.value = index;
  }

  Widget buildDrawer() => Drawer(
    backgroundColor: Colors.white,
    child: Column(
      children: [
        SizedBox(
          height: context.height * 0.3,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  AssetsManager.drawer,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 30, top: 15),
                child: SafeArea(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          imageUrl:
                              ApiEndpoints.imageProvider + (user.image ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      user.name,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: AppPalette.secondaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      'orphanage',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppPalette.secondaryTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: const Icon(Icons.bookmark),
                title: Text('Saved posts', style: context.textTheme.bodyLarge),
                onTap: () {
                  context.pop();
                  context.push(SavedPostsScreen());
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.notifications),
              //   title: Text(
              //     'Notifications',
              //     style: context.textTheme.bodyLarge,
              //   ),
              //   trailing: ValueListenableBuilder<bool>(
              //     valueListenable: isNotificationEnabled,
              //     builder: (context, enabled, _) => Switch(
              //       activeTrackColor: AppPalette.primaryColor,
              //       value: enabled,
              //       onChanged: (value) {
              //         toggleNotification(value);
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Divider(),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: TextButton(
            onPressed: () {
              Helpers.logout();
              context.pushAndRemoveUntil(const LoginView());
            },
            child: Row(
              spacing: 10,
              children: [
                Icon(Icons.logout, color: AppPalette.primaryColor),
                Text(
                  'Logout',
                  style: context.textTheme.headlineLarge?.copyWith(
                    color: AppPalette.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );
  void toggleNotification(bool enabled) {
    isNotificationEnabled.value = enabled;
    FirebaseMessaging.instance.setAutoInitEnabled(enabled);
  }
}

class _BottomAppBarBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double notchMargin;

  _BottomAppBarBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.notchMargin,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Draw left rounded part
    final leftArcRadius = Radius.circular(28);
    final leftArcRect = Rect.fromLTWH(
      0,
      0,
      leftArcRadius.x * 2,
      leftArcRadius.y * 2,
    );
    canvas.drawArc(leftArcRect, -pi, pi / 2, false, paint);

    // Draw right rounded part
    final rightArcRect = Rect.fromLTWH(
      size.width - leftArcRadius.x * 2,
      0,
      leftArcRadius.x * 2,
      leftArcRadius.y * 2,
    );
    canvas.drawArc(rightArcRect, -pi / 2, pi / 2, false, paint);

    // Draw top lines
    canvas.drawLine(
      Offset(leftArcRadius.x, 0),
      Offset(size.width / 2 - notchMargin - leftArcRadius.x, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width / 2 + notchMargin + leftArcRadius.x, 0),
      Offset(size.width - leftArcRadius.x, 0),
      paint,
    );

    // Draw notch curve
    final notchRect = Rect.fromCircle(
      center: Offset(size.width / 2, 0),
      radius: notchMargin + leftArcRadius.x,
    );
    canvas.drawArc(notchRect, 0, pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
