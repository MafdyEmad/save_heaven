import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_heaven/core/config/app_theme.dart';
import 'package:save_heaven/splash_screen.dart';

class SaveHeaven extends StatelessWidget {
  const SaveHeaven({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(theme: AppTheme.light, home: const SplashScreen()),
    );
  }
}
