import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/features/adoption/presentation/pages/adoption_procedures_page.dart';
import 'package:save_heaven/features/kids/data/models/kid_model.dart';

class KidProfileCard extends StatelessWidget {
  final KidModel kid;

  const KidProfileCard({super.key, required this.kid});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: const Color(0xFFF8F8F8),
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.02,
      ),
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.01),
                      Text(
                        "${kid.age}-year-old, ${kid.gender}, ${kid.hairType}\n${kid.religion}, ${kid.educationLevel}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: Colors.black54,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Image.asset(kid.orphanageIcon, width: 20),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: CustomButton(
                width: screenWidth * .3,
                height: 40,
                text: "Adopt",
                onPressed: () {
                  context.push(AdoptionProceduresPage());
                },
                backgroundColor: AppColors.primary,
                // fontSize: screenWidth * 0.035,
                borderRadius: 12,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02, // قلل العرض
                  vertical: screenWidth * 0.01,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
