import 'package:flutter/material.dart';
import 'package:save_heaven/core/config/app_palette.dart';

Future<void> showLoading(context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        content: Center(child: CircularProgressIndicator(color: AppPalette.primaryColor)),
      ),
    ),
  );
}
