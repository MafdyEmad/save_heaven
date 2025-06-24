import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/assets_images.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/features/donation/data/models/orphanage_model.dart';
import 'package:save_heaven/features/donation/presentation/pages/donation_type_page.dart';

class OrphanageCard extends StatelessWidget {
  final OrphanageModel model;

  const OrphanageCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: width * 0.035, horizontal: width * 0.03),
      height: width * 0.6,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(model.logo, height: width * 0.1, fit: BoxFit.contain),
          SizedBox(height: width * 0.01),
          Text(
            model.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.03),
          ),
          SizedBox(height: width * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetsImages.visa, width: 24, height: 24),
              const SizedBox(width: 4),
              Image.asset(AssetsImages.mastarCard, width: 24, height: 24),
            ],
          ),
          SizedBox(height: width * 0.02),
          CustomButton(
            text: "Donate♡",
            onPressed: () {
              context.push(const DonationTypePage());
            },
          ),

          SizedBox(height: width * 0.02),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                model.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width * 0.03, color: Colors.black54),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
