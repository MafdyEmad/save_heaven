import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/features/kids/data/models/orphanage_near_card_model.dart';

class OrphanageNearCard extends StatelessWidget {
  final OrphanageNearCardModel model;

  const OrphanageNearCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(width * 0.025),
      padding: EdgeInsets.all(width * 0.025),
      height: width * 0.42, 
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            model.imageUrl,
            height: width * 0.1, 
            fit: BoxFit.contain,
          ),
          SizedBox(height: width * 0.015),

          Text(
            model.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: width * 0.03, 
            ),
          ),
          SizedBox(height: width * 0.01),

          Text(
            model.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: width * 0.026,
              color: Colors.black54,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const Spacer(),

          CustomButton(
            text: "Donate♡",
            onPressed: () {},
            width: width * 0.42,
            height: width * 0.08, 
            fontSize: width * 0.03,
            padding: EdgeInsets.zero,
            borderRadius: 8,
          ),
        ],
      ),
    );
  }
}
