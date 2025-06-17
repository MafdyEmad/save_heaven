import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/config/assets_manager.dart';
import 'package:save_heaven/core/hive/adapters/app_config_adapter/app_config_model.dart';
import 'package:save_heaven/core/hive/hive_boxes/hive_boxes.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/shared/features/home/presentation/screens/home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  final ValueNotifier<double> _pageNotifier = ValueNotifier(0.0);

  final pages = [
    OnboardingPage(
      title: 'Welcome to Safe Haven!',
      description: 'A secure place to connect, support, and build brighter futures together.',
      image: AssetsManager.onBoardingImage1,
    ),
    OnboardingPage(
      title: 'Explore our network of orphanages, volunteers, and professionals',
      description: 'Where every skill makes a difference.',
      image: AssetsManager.onBoardingImage2,
    ),
    OnboardingPage(
      title: 'Every child deserves a loving home.',
      description: 'Let’s create a safe haven for every child.',
      image: AssetsManager.onBoardingImage3,
    ),
  ];

  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page != null) {
        _pageNotifier.value = _pageController.page!;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: ClipPath(
              clipper: CircularBottomClipper(),
              child: Stack(
                children: [
                  ValueListenableBuilder<double>(
                    valueListenable: _pageNotifier,
                    builder: (context, value, child) {
                      return Stack(
                        children: [
                          ValueListenableBuilder<double>(
                            valueListenable: _pageNotifier,
                            builder: (context, value, child) {
                              return SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    AnimatedOpacity(
                                      opacity: 1,
                                      duration: Duration(milliseconds: 200),
                                      child: Image.asset(
                                        pages[0].image,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                    AnimatedOpacity(
                                      opacity: value > 1 ? 1 : value,
                                      duration: Duration(milliseconds: 200),
                                      child: Image.asset(
                                        pages[1].image,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                    AnimatedOpacity(
                                      opacity: value >= 2 ? 1 : (value - 1).clamp(0, 1),
                                      duration: Duration(milliseconds: 200),
                                      child: Image.asset(
                                        pages[2].image,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPagePadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pages[index].title,
                        style: context.textTheme.titleLarge?.copyWith(
                          color: AppPalette.primaryColor,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        pages[index].description,
                        style: context.textTheme.bodyLarge?.copyWith(color: AppPalette.primaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPagePadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: pages.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppPalette.primaryColor,
                    dotHeight: 8.w,
                    dotWidth: 8.w,
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: 45.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppPalette.primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () async {
                        AppConfigModel updatedConfig = AppConfigModel(isFirstTime: false);
                        await HiveBoxes.appConfigBox.putAt(0, updatedConfig);
                        _navigateToNextScreen();
                      },
                      child: Text(
                        'Skip',
                        style: context.textTheme.headlineLarge?.copyWith(
                          color: AppPalette.secondaryTextColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _navigateToNextScreen() {
    context.pushReplacement(const HomeScreen());
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String image;

  OnboardingPage({required this.title, required this.description, required this.image});
}

class CircularBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 200);
    path.arcToPoint(
      Offset(size.width, size.height - 200),
      radius: Radius.circular(size.width / 6),
      clockwise: false,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
