import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/assets_images.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/auth/data/data_scource/auth_remote_data_source.dart';
import 'package:save_heaven/features/auth/presentation/views/orphanage_admin_view.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/utils/widgets reuseable/circle_back_button.dart';
import '../../../../core/utils/widgets reuseable/custom_button.dart';
import '../../../../core/utils/widgets reuseable/custom_text_field.dart';

class OrphanageSignupBody extends StatefulWidget {
  const OrphanageSignupBody({super.key});

  @override
  State<OrphanageSignupBody> createState() => _OrphanageSignupBodyState();
}

class _OrphanageSignupBodyState extends State<OrphanageSignupBody> {
  final ValueNotifier<bool> passwordVisibilityNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordVisibilityNotifier = ValueNotifier(true);
  final formKey = GlobalKey<FormState>();
  final establishDateController = TextEditingController();
  DateTime? selectedDate;

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final contactController = TextEditingController();
  @override
  void dispose() {
    establishDateController.dispose();
    nameController.dispose();
    locationController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const CircleBackButton(),
              SizedBox(height: size.height * 0.02),
              Center(child: Image.asset(AssetsImages.hand, height: size.height * 0.08)),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  "Welcome",
                  style: TextStyle(fontSize: size.width * 0.06, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),

              CustomTextField(
                hint: 'Name Of Orphanage',
                icon: Icons.people,
                controller: nameController,
                validator: Validators.requiredField,
              ),
              CustomTextField(
                hint: 'Location',
                icon: Icons.location_on,
                controller: locationController,
                validator: Validators.requiredField,
              ),

              // Password field with visibility toggle
              ValueListenableBuilder<bool>(
                valueListenable: passwordVisibilityNotifier,
                builder: (_, isVisible, _) {
                  return CustomTextField(
                    hint: 'Password',
                    icon: Icons.lock,
                    controller: passwordController,
                    isPassword: true,
                    isVisible: isVisible,
                    onToggleVisibility: () => passwordVisibilityNotifier.value = !isVisible,
                    validator: Validators.password,
                  );
                },
              ),

              ValueListenableBuilder<bool>(
                valueListenable: confirmPasswordVisibilityNotifier,
                builder: (_, isVisible, _) {
                  return CustomTextField(
                    hint: 'Confirm Password',
                    icon: Icons.lock_outline,
                    controller: confirmPasswordController,
                    isPassword: true,
                    isVisible: isVisible,
                    onToggleVisibility: () => confirmPasswordVisibilityNotifier.value = !isVisible,
                    validator: (val) => Validators.confirmPassword(val, passwordController.text),
                  );
                },
              ),

              CustomTextField(
                hint: 'Contact Number',
                icon: Icons.phone,
                controller: contactController,
                validator: Validators.phone,
              ),
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    selectedDate = picked;
                    establishDateController.text =
                        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                    setState(() {});
                  }
                },
                child: AbsorbPointer(
                  child: CustomTextField(
                    hint: 'Establishment Date',
                    icon: Icons.calendar_today,
                    controller: establishDateController,
                    validator: Validators.requiredField,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              CustomButton(
                text: "Next",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final dateOnly =
                        "${selectedDate!.year.toString().padLeft(4, '0')}"
                        "-${selectedDate!.month.toString().padLeft(2, '0')}"
                        "-${selectedDate!.day.toString().padLeft(2, '0')}";
                    final params = OrphanageSignUpParams(
                      name: nameController.text.trim(),
                      address: locationController.text.trim(),
                      password: passwordController.text,
                      passwordConfirm: confirmPasswordController.text,
                      phone: contactController.text.trim(),
                      establishedDate: dateOnly,
                    );
                    context.push(OrphanageAdminView(currentParams: params));
                  }
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
