import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/assets_images.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_dialog.dart';
import 'package:save_heaven/core/utils/validators.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/donor_nav_screen.dart';
import 'package:save_heaven/features/auth/presentation/cubit/auth_cubit.dart';
import '../../../../core/utils/widgets reuseable/custom_text_field.dart';
import '../../../../core/utils/widgets reuseable/custom_dropdown.dart';
import '../../../../core/utils/widgets reuseable/circle_back_button.dart';

class UserSignupBody extends StatefulWidget {
  const UserSignupBody({super.key});

  @override
  State<UserSignupBody> createState() => _UserSignupBodyState();
}

class _UserSignupBodyState extends State<UserSignupBody> {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final birthdateController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final ValueNotifier<bool> passwordVisibilityNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordVisibilityNotifier = ValueNotifier(true);
  final ValueNotifier<String?> genderNotifier = ValueNotifier(null);
  final donorSignUpStates = List.unmodifiable([DonorSignUpLoading, DonorSignUpFail, DonorSignUpSuccess]);
  DateTime? birthdate;
  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    birthdateController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  final bloc = getIt<AuthCubit>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: bloc,
      child: Builder(
        builder: (blocContext) {
          return BlocConsumer<AuthCubit, AuthState>(
            buildWhen: (previous, current) => donorSignUpStates.contains(current.runtimeType),
            listener: (context, state) {
              if (state is DonorSignUpSuccess) {
                context.pushAndRemoveUntil(const DonorNavScreen());
              } else if (state is DonorSignUpFail) {
                showCustomDialog(
                  context,
                  title: "Sign Up failed",
                  content: state.message,
                  confirmText: "Try again",
                  cancelText: '',
                  onConfirm: () {
                    context.pop();
                  },
                  onCancel: () {},
                );
              }
            },
            builder: (context, state) => SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                child: Form(
                  key: formKey,
                  child: IgnorePointer(
                    ignoring: state is DonorSignUpLoading,
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
                          hint: 'Full-Name',
                          icon: Icons.person,
                          controller: fullNameController,
                          validator: Validators.requiredField,
                        ),
                        CustomTextField(
                          hint: 'Email',
                          icon: Icons.email,
                          controller: emailController,
                          validator: Validators.email,
                        ),
                        CustomTextField(
                          hint: 'Birthdate',
                          icon: Icons.calendar_month,
                          controller: birthdateController,
                          validator: Validators.requiredField,
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              final formattedDate =
                                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                              birthdateController.text = formattedDate;
                              birthdate = pickedDate;
                            }
                          },
                        ),

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
                              icon: Icons.lock,
                              controller: confirmPasswordController,
                              isPassword: true,
                              isVisible: isVisible,
                              onToggleVisibility: () => confirmPasswordVisibilityNotifier.value = !isVisible,
                              validator: (val) => Validators.confirmPassword(val, passwordController.text),
                            );
                          },
                        ),

                        CustomTextField(
                          hint: 'Phone Number',
                          icon: Icons.phone,
                          controller: phoneController,
                          validator: Validators.phone,
                        ),
                        CustomTextField(
                          hint: 'Address',
                          icon: Icons.location_on,
                          controller: addressController,
                          validator: Validators.address,
                        ),

                        ValueListenableBuilder(
                          valueListenable: genderNotifier,
                          builder: (context, gender, child) => CustomDropdown(
                            hint: 'Gender',
                            value: gender,
                            onChanged: (value) {
                              genderNotifier.value = value;
                            },
                          ),
                        ),

                        const SizedBox(height: 24),
                        if (state is DonorSignUpLoading)
                          Center(child: CircularProgressIndicator(color: AppPalette.primaryColor))
                        else
                          CustomButton(
                            text: 'Signup',
                            onPressed: () {
                              if (validateForm()) {
                                final dateOnly =
                                    "${birthdate!.year.toString().padLeft(4, '0')}"
                                    "-${birthdate!.month.toString().padLeft(2, '0')}"
                                    "-${birthdate!.day.toString().padLeft(2, '0')}";

                                bloc.donorSignUp(
                                  name: fullNameController.text.trim(),
                                  address: addressController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  phone: phoneController.text.trim(),
                                  birthdate: dateOnly,
                                  gender: genderNotifier.value!.toLowerCase(),
                                );
                              }

                              // else if (selectedGender == null) {
                              //   ScaffoldMessenger.of(
                              //     context,
                              //   ).showSnackBar(const SnackBar(content: Text('Please select gender')));
                              // }
                            },
                          ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool validateForm() {
    if (!formKey.currentState!.validate()) return false;
    if (genderNotifier.value == null) return false;
    return true;
  }
}
