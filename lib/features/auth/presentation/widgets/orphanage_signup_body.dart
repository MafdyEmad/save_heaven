import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/assets_images.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/auth/presentation/views/orphanage_admin_view.dart';

import '../../../../core/utils/validators.dart';
import '../manager/orphanage signup cubit/orphanage_signup_cubit.dart';
import '../../../../core/utils/widgets reuseable/circle_back_button.dart';
import '../../../../core/utils/widgets reuseable/custom_button.dart';
import '../../../../core/utils/widgets reuseable/custom_text_field.dart';

class OrphanageSignupBody extends StatelessWidget {
  const OrphanageSignupBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> passwordVisibilityNotifier = ValueNotifier(false);
    final ValueNotifier<bool> confirmPasswordVisibilityNotifier = ValueNotifier(false);
    final cubit = context.read<OrphanageSignupCubit>();
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
        child: Form(
          key: cubit.formKey,
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
                controller: cubit.nameController,
                validator: Validators.requiredField,
              ),
              CustomTextField(
                hint: 'Location',
                icon: Icons.location_on,
                controller: cubit.locationController,
                validator: Validators.requiredField,
              ),

              // Password field with visibility toggle
              ValueListenableBuilder<bool>(
                valueListenable: passwordVisibilityNotifier,
                builder: (_, isVisible, _) {
                  return CustomTextField(
                    hint: 'Password',
                    icon: Icons.lock,
                    controller: cubit.passwordController,
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
                    controller: cubit.confirmPasswordController,
                    isPassword: true,
                    isVisible: isVisible,
                    onToggleVisibility: () => confirmPasswordVisibilityNotifier.value = !isVisible,
                    validator: (val) => Validators.confirmPassword(val, cubit.passwordController.text),
                  );
                },
              ),

              CustomTextField(
                hint: 'Contact Number',
                icon: Icons.phone,
                controller: cubit.contactController,
                validator: Validators.phone,
              ),

              const SizedBox(height: 24),
              CustomButton(
                text: "Next",
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    context.push(const OrphanageAdminView());
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
