import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_loading.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/adoption/presentation/pages/adoption_success_page.dart';
import 'package:save_heaven/features/adoption/presentation/pages/widgets/custom_request_field.dart';
import 'package:save_heaven/features/kids/presentation/cubit/orphanage%20cubit/orphanage_near_cubit.dart';
import 'package:save_heaven/features/kids/presentation/cubit/orphanges_cubit.dart';
import 'package:save_heaven/features/kids/presentation/data_source/remote_data_source.dart';
import 'package:save_heaven/features/profile/data/models/child_model.dart';

class AdoptionRequestFormPage extends StatefulWidget {
  final ChildModel child;
  const AdoptionRequestFormPage({super.key, required this.child});

  @override
  State<AdoptionRequestFormPage> createState() =>
      _AdoptionRequestFormPageState();
}

class _AdoptionRequestFormPageState extends State<AdoptionRequestFormPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final bloc = getIt<OrphanageNearCubit>();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    jobController.dispose();
    addressController.dispose();
    dateController.dispose();
    nationalityController.dispose();
    incomeController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  String? gender;
  String? religion;
  String? location;
  String? maritalStatus;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Builder(
      builder: (context) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;

        return BlocProvider.value(
          value: bloc,
          child: Builder(
            builder: (context) {
              return BlocListener<OrphanageNearCubit, OrphangesState>(
                listener: (context, state) {
                  if (state is AdoptLoaded) {
                    context.pop();
                    context.push(const AdoptionSuccessPage());
                  }
                  if (state is AdoptError) {
                    context.pop();
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                  if (state is AdoptLoading) {
                    showLoading(context);
                  }
                },
                child: Scaffold(
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
                                label: "Marital Status",
                                hintText: "Select Marital Status",
                                dropdownItems: const ["Married", "Single"],
                                selectedValue: maritalStatus,
                                onChanged: (val) => maritalStatus = val,
                                validator: (val) => val == null || val.isEmpty
                                    ? "Marital Status is required"
                                    : null,
                              ),
                              CustomRequestField(
                                label: "Occupation",
                                hintText: "Enter your job",
                                controller: jobController,
                              ),
                              CustomRequestField(
                                label: "Monthly Income",
                                hintText: "Enter your income",
                                controller: incomeController,
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
                                selectedValue: religion,
                                onChanged: (val) => religion = val,
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
                                selectedValue: location,
                                onChanged: (val) => location = val,
                                validator: (val) => val == null || val.isEmpty
                                    ? "Location is required"
                                    : null,
                              ),
                              CustomRequestField(
                                label: "Phone Number",
                                hintText: "Enter 11-digit number",
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                validator: (val) =>
                                    val == null || val.length != 11
                                    ? "Phone number must be 11 digits"
                                    : null,
                              ),
                              Text(
                                "Why Do You Want To Adopt?",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: width * 0.037,
                                ),
                              ),
                              const SizedBox(height: 4),
                              CustomTextField(
                                maxLines: 4,
                                controller: reasonController,
                                hint: "Write your motivation",
                                validator: (val) => val == null || val.isEmpty
                                    ? "This field is required"
                                    : null,
                              ),

                              const SizedBox(height: 20),
                              CustomButton(
                                text: "Submit Request",
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    bloc.adopt(
                                      AdoptionRequest(
                                        orphanageId: widget.child.orphanage.id,
                                        childId: widget.child.id,
                                        phone: phoneController.text.trim(),
                                        maritalStatus: maritalStatus!,
                                        occupation: jobController.text.trim(),
                                        monthlyIncome:
                                            int.tryParse(
                                              incomeController.text.trim(),
                                            ) ??
                                            0,
                                        religion: religion!,
                                        location: location!,
                                        reason: reasonController.text.trim(),
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
                ),
              );
            },
          ),
        );
      },
    );
  }
}
