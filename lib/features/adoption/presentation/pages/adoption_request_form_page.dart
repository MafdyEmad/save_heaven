import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/features/adoption/presentation/cubit/adoption_request_cubit.dart';
import 'package:save_heaven/features/adoption/presentation/pages/adoption_success_page.dart';
import 'package:save_heaven/features/adoption/presentation/pages/widgets/custom_request_field.dart';

class AdoptionRequestFormPage extends StatelessWidget {
  const AdoptionRequestFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => AdoptionRequestCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<AdoptionRequestCubit>();
          final formKey = GlobalKey<FormState>();

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.06,
                vertical: height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
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
                      const Text(
                        "Adoption Request Form",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRequestField(
                          label: "Occupation",
                          hintText: "Enter your job",
                          controller: cubit.jobController,
                        ),
                        CustomRequestField(
                          label: "Monthly Income",
                          hintText: "Enter your income",
                          controller: cubit.incomeController,
                          keyboardType: TextInputType.number,
                          validator: (val) => val == null || val.isEmpty
                              ? "Monthly income is required"
                              : null,
                        ),
                        CustomRequestField(
                          label: "Religion",
                          hintText: "Select religion",
                          dropdownItems: const [
                            "Islam",
                            "Christianity",
                            "Other",
                          ],
                          selectedValue: cubit.religion,
                          onChanged: (val) => cubit.religion = val,
                          validator: (val) => val == null || val.isEmpty
                              ? "Religion is required"
                              : null,
                        ),
                        CustomRequestField(
                          label: "Location",
                          hintText: "Select location",
                          dropdownItems: const [
                            "Cairo",
                            "Alexandria",
                            "Giza",
                            "Other",
                          ],
                          selectedValue: cubit.location,
                          onChanged: (val) => cubit.location = val,
                          validator: (val) => val == null || val.isEmpty
                              ? "Location is required"
                              : null,
                        ),
                        CustomRequestField(
                          label: "Phone Number",
                          hintText: "Enter 11-digit number",
                          controller: cubit.phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (val) => val == null || val.length != 11
                              ? "Phone number must be 11 digits"
                              : null,
                        ),
                        CustomRequestField(
                          label: "Why Do You Want To Adopt?",
                          hintText: "Write your motivation",
                          controller: cubit.reasonController,
                          maxLines: 4,
                          validator: (val) => val == null || val.isEmpty
                              ? "This field is required"
                              : null,
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: "Submit Request",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.push(
                                const AdoptionSuccessPage(
                                  requestId: "#123456",
                                  submissionDate: "February 27, 2025",
                                  applicantName: "John Doe",
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
