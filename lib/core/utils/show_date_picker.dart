import 'package:flutter/material.dart';
import 'package:save_heaven/core/config/app_palette.dart';

Future<DateTime?> showCustomDatePicker(
  context, {
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) async {
  return showDatePicker(
    context: context,
    firstDate: firstDate,
    initialDate: initialDate,
    lastDate: lastDate,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppPalette.primaryColor,
            onPrimary: AppPalette.backgroundColor,
          ),
        ),
        child: child!,
      );
    },
  );
}
