import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/app_colors.dart';

class BottomCurve extends StatelessWidget {
  const BottomCurve({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.bottomLeft,
      child: Transform.translate(
        offset: Offset(-width * 0.1, width * 0.3),
        child: Container(
          width: width * 0.85,
          height: width * 0.85,
          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
