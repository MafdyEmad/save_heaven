import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/app_colors.dart';

class CircleNextButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CircleNextButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
          ),
          padding: const EdgeInsets.all(6),
          child: const Icon(Icons.arrow_forward, color: AppColors.white, size: 24),
        ),
      ),
    );
  }
}
