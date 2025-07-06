import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/assets_images.dart';

class AwarenessBanner extends StatelessWidget {
  const AwarenessBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage(AssetsImages.banner),
          alignment: Alignment.centerRight,
          fit: BoxFit.contain,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Take Action Today:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "Visit SOS Children's Villages Or A Local Orphanage Near You To Learn More\nAbout Adoption Or Donation.\nShare To Spread Inspire Others To Help",
            style: TextStyle(color: AppColors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
