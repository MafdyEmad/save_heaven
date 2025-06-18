import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/features/kids/data/models/kid_model.dart';

class KidCard extends StatelessWidget {
  final KidModel kid;

  const KidCard({super.key, required this.kid});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: const Color(0xFFF8F8F8),
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    kid.imageUrl,
                    width: screenWidth * 0.15,
                    height: screenWidth * 0.15,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kid.name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.045),
                      ),
                      Text(
                        "${kid.age}-year-old, ${kid.gender}, ${kid.hairType}\n${kid.religion}, ${kid.educationLevel}",
                        style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.04),
            CustomButton(text: "Adopt", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
