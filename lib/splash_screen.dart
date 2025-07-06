import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/config/assets_manager.dart';
import 'package:save_heaven/core/hive/adapters/app_config_adapter/app_config_model.dart';
import 'package:save_heaven/core/hive/adapters/user_adapter/user_hive.dart';
import 'package:save_heaven/core/hive/hive_boxes/hive_boxes.dart';
import 'package:save_heaven/core/services/web_socket.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/donor_nav_screen.dart';
import 'package:save_heaven/features/auth/presentation/views/start_journey_view.dart';
import 'package:save_heaven/features/on_boarding/screens/onboarding_screen.dart';
import 'package:save_heaven/orphanage_nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _textSlideAnimation;
  late final Animation<Offset> _upperSlideAnimation;
  late final Animation<Offset> _lowerSlideAnimation;
  late final Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _upperSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _lowerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _logoScaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 2), () => _goToNextScreen());
      }
    });
  }

  void _goToNextScreen() async {
    AppConfigModel appConfig = HiveBoxes.appConfigBox.getAt(0);

    if (appConfig.isFirstTime) {
      context.pushReplacement(OnboardingScreen());
    } else {
      final secureBox = HiveBoxes.secureBox;
      if (secureBox.isNotEmpty) {
        final String token = secureBox.getAt(0);
        final userId = JwtDecoder.decode(token)['userId'];

        final UserHive user = HiveBoxes.userBox.get(userId);
        if (user.role == 'Donor') {
          context.pushReplacement(DonorNavScreen());
        } else {
          context.pushReplacement(OrphanageNavScreen());
        }
        return;
      }
      context.pushReplacement(StartJourneyView());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SlideTransition(
            position: _upperSlideAnimation,
            child: SvgPicture.asset(
              AssetsManager.splashUpper,
              fit: BoxFit.fill,
              width: context.width,
            ),
          ),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _textSlideAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _logoScaleAnimation,
                      child: Image.asset(AssetsManager.appIcon),
                    ),
                    SizedBox(
                      width: 150,
                      child: FittedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Safe\nHaven',
                              style: context.textTheme.titleLarge?.copyWith(
                                color: AppPalette.primaryColor,
                                fontSize: 60.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'Love in every gesture',
                              style: context.textTheme.headlineMedium?.copyWith(
                                color: AppPalette.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SlideTransition(
            position: _lowerSlideAnimation,
            child: SvgPicture.asset(
              AssetsManager.splashLower,
              fit: BoxFit.fill,
              width: context.width,
            ),
          ),
        ],
      ),
    );
  }
}
