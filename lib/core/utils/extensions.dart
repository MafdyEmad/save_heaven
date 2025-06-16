import 'package:flutter/material.dart';
import 'package:save_heaven/core/navigations/custom_navigation.dart';

extension Navigation on BuildContext {
  Future<dynamic> push(Widget screen) {
    return CustomNavigation.push(this, screen);
  }

  Future<dynamic> pushReplacement(Widget screen) {
    return CustomNavigation.pushReplacement(this, screen);
  }

  Future<dynamic> pushAndRemoveUntil(Widget screen) {
    return CustomNavigation.pushAndRemoveUntil(this, screen);
  }

  void pop([result]) => CustomNavigation.pop(this, result);
}

extension ScreenWidth on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
}

extension GetTextTheme on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
