import 'package:flutter/material.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'text_styles_manager.dart';

class AppTheme {
  static final _primaryColor = AppPalette.primaryColor;
  static final _backGroundColor = AppPalette.backgroundColor;
  static ThemeData light = ThemeData.light().copyWith(
    cardTheme: CardThemeData(
      color: AppPalette.foregroundColor,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: _backGroundColor,
      confirmButtonStyle: ButtonStyle(textStyle: WidgetStatePropertyAll(TextStylesManager.bodyLargeLight)),
      cancelButtonStyle: ButtonStyle(textStyle: WidgetStatePropertyAll(TextStylesManager.bodyLargeLight)),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return _primaryColor;
        }
        return AppPalette.hintColor;
      }),
      overlayColor: WidgetStateProperty.all(_primaryColor.withAlpha(100)),
      splashRadius: 24,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: _primaryColor, shape: StadiumBorder()),
    ),
    scaffoldBackgroundColor: _backGroundColor,
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: _backGroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: _primaryColor),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _primaryColor,
      selectionHandleColor: _primaryColor,
      selectionColor: _primaryColor.withAlpha(100),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      hintStyle: TextStylesManager.bodyLargeLight,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: _primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStylesManager.titleLargeLight,
      titleMedium: TextStylesManager.titleMediumLight,
      titleSmall: TextStylesManager.titleSmallLight,

      headlineLarge: TextStylesManager.headlineLargeLight,
      headlineMedium: TextStylesManager.headlineMediumLight,
      headlineSmall: TextStylesManager.headlineSmallLight,

      bodyLarge: TextStylesManager.bodyLargeLight,
      bodyMedium: TextStylesManager.bodyMediumLight,
      bodySmall: TextStylesManager.bodySmallLight,
    ),
  );
}
