import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.padding,
    this.fontSize,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final defaultWidth = screen.width * 0.65;
    final defaultHeight = screen.height * 0.06;
    final defaultFontSize = screen.width * 0.04;

    return Padding(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: screen.width * 0.18, vertical: screen.height * 0.025),
      child: SizedBox(
        width: width ?? defaultWidth,
        height: height ?? defaultHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 11)),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize ?? defaultFontSize, color: textColor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}
