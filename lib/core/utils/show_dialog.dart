import 'package:flutter/material.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';

void showCustomDialog(
  context, {
  required String title,
  String? emoji,
  bool canPop = true,
  required String content,
  required String confirmText,
  required String cancelText,
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
              style: context.textTheme.headlineLarge?.copyWith(fontSize: 16, color: Colors.redAccent),
            ),
          ),
          CustomButton(text: confirmText, onPressed: onConfirm!),
          // ElevatedButton(
          //   onPressed: onConfirm,
          //   child: Text(
          //     confirmText,
          //     style: context.textTheme.headlineLarge?.copyWith(color: AppPalette.secondaryTextColor),
          //   ),
          // ),
        ],
      ),
    ),
  );
}
