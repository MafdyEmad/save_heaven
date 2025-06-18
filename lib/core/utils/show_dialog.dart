import 'package:flutter/material.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/extensions.dart';

void showCustomDialog(
  context, {
  required String title,
  String? emoji,
  bool canPop = true,
  required String content,
  required String confirmText,
  required String cancelText,
  Color cancelTextColor = Colors.red,
  required void Function()? onConfirm,
  required void Function()? onCancel,
}) {
  showDialog(
    context: context,
    barrierDismissible: !canPop,
    builder: (context) => PopScope(
      canPop: canPop,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppPalette.backgroundColor,
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.textTheme.titleLarge?.copyWith(color: AppPalette.primaryColor),
              ),
            ),
          ],
        ),
        content: Text(content, style: context.textTheme.headlineLarge),
        actions: [
          TextButton(
            onPressed: onCancel,
            child: Text(
              cancelText,
              style: context.textTheme.headlineLarge?.copyWith(fontSize: 16, color: cancelTextColor),
            ),
          ),
          ElevatedButton(
            onPressed: onConfirm,
            child: Text(
              confirmText,
              style: context.textTheme.headlineLarge?.copyWith(color: AppPalette.secondaryTextColor),
            ),
          ),
        ],
      ),
    ),
  );
}
