// 📁 features/adoption/presentation/pages/adoption_success_page.dart

import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/features/kids/presentation/pages/kids_home_view.dart';

class AdoptionSuccessPage extends StatelessWidget {
  final String requestId;
  final String submissionDate;
  final String applicantName;

  const AdoptionSuccessPage({
    super.key,
    required this.requestId,
    required this.submissionDate,
    required this.applicantName,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              "Request Submitted Successfully!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Thank You For Submitting Your Adoption Request.\nOur Team Will Review It And Contact You Soon.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // ✅ Application Details Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade100),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Application Details",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text("Request ID: $requestId"),
                  Text("Submission Date: $submissionDate"),
                  Text("Applicant Name: $applicantName"),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "You Can Done Your Request And Return To The Homepage.",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            CustomButton(
              text: "Done",
              onPressed: () {
                context.push(const KidsHomeView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
