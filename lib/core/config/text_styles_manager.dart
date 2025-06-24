import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_heaven/core/config/app_palette.dart';

class TextStylesManager {
  static const _defaultColor = Colors.black;
  static TextStyle get titleLargeLight =>
      TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w500, color: _defaultColor);
  static TextStyle get titleMediumLight =>
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: _defaultColor);
  static TextStyle get titleSmallLight =>
      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500, color: _defaultColor);

  static TextStyle get headlineLargeLight =>
      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, color: _defaultColor);
  static TextStyle get headlineMediumLight =>
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: _defaultColor);
  static TextStyle get headlineSmallLight =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: _defaultColor);

  static TextStyle get bodyLargeLight =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: _defaultColor);
  static TextStyle get bodyMediumLight =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: _defaultColor);
  static TextStyle get bodySmallLight =>
      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500, color: _defaultColor);
}
