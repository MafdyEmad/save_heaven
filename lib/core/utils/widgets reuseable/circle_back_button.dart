import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/extensions.dart';

class CircleBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CircleBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: onTap ?? () => context.pop(),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
          ),
          padding: const EdgeInsets.all(6),
          child: const Icon(Icons.arrow_back, color: AppColors.white, size: 18),
        ),
      ),
    );
  }
}
