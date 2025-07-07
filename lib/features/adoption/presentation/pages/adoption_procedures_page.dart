import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/features/adoption/presentation/pages/adoption_request_form_page.dart';
import 'package:save_heaven/features/profile/data/models/child_model.dart';

class AdoptionProceduresPage extends StatelessWidget {
  final ChildModel child;
  const AdoptionProceduresPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Adoption Procedures",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildStepCard(
                context,
                title: "Step 1: Submit Application",
                description:
                    "Complete The Adoption Request Form With Your Details.",
              ),
              _buildStepCard(
                context,
                title: "Step 2: Initial Screening",
                description:
                    "Our Team Will Review Your Application And We Will Contact You.",
              ),
              _buildStepCard(
                context,
                title: "Step 3: Home Visit",
                description:
                    "A Social Worker Will Visit Your Home To Assess The Environment.",
              ),
              _buildStepCard(
                context,
                title: "Step 4: Approval & Matching",
                description:
                    "Once Approved, We Match You With A Child Based On Your Preferences.",
              ),
              _buildStepCard(
                context,
                title: "Step 5: Legal Finalization",
                description:
                    "Complete Legal Procedures To Finalize The Adoption Process.",
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: 'Start Adoption',
                onPressed: () {
                  context.push(AdoptionRequestFormPage(child: child));
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepCard(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: width * 0.04),
      padding: EdgeInsets.all(width * 0.035),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: Color(0xFF2196F3)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
