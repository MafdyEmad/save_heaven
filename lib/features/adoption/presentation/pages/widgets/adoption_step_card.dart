// 📁 المسار: features/adoption/presentation/widgets/adoption_step_card.dart

import 'package:flutter/material.dart';

class AdoptionStepCard extends StatelessWidget {
  final String stepTitle;
  final String description;

  const AdoptionStepCard({
    super.key,
    required this.stepTitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: width * 0.04),
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stepTitle, style: TextStyle(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold,
                )),
                const SizedBox(height: 6),
                Text(description, style: TextStyle(
                  fontSize: width * 0.035,
                  color: Colors.grey[700],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}