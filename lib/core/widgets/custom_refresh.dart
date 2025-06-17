import 'package:flutter/material.dart';
import 'package:save_heaven/core/config/app_palette.dart';

class CustomRefresh extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  const CustomRefresh({super.key, required this.child, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      backgroundColor: AppPalette.foregroundColor,
      color: AppPalette.primaryColor,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: child,
    );
  }
}
