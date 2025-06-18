import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/assets_images.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_dialog.dart';
import 'package:save_heaven/core/utils/validators.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/donor_nav_screen.dart';
import 'package:save_heaven/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:save_heaven/features/auth/presentation/manager/Password%20Visibility%20Cubit/password_visibility_cubit.dart';
import 'package:save_heaven/features/auth/presentation/views/sign_up_as_view.dart';
import 'package:save_heaven/features/auth/presentation/widgets/components/bottom_curve.dart';
import 'package:save_heaven/orphanage_nav_screen.dart';

class LoginBody extends StatelessWidget {
  LoginBody({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final loginStates = List.unmodifiable([LoginLoading, LoginFail, LoginSuccess]);
  final cubit = getIt<AuthCubit>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return BlocProvider.value(
      value: cubit,
      child: Builder(
        builder: (context) {
          return BlocConsumer<AuthCubit, AuthState>(
            buildWhen: (previous, current) => loginStates.contains(current.runtimeType),
            listener: (context, state) {
              if (state is LoginSuccess) {
                state.user.role == 'Orphanage'
                    ? context.pushAndRemoveUntil(const OrphanageNavScreen())
                    : context.pushAndRemoveUntil(const DonorNavScreen());
              } else if (state is LoginFail) {
                showCustomDialog(
                  context,
                  title: "Login failed",
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
            builder: (context, state) {
              return IgnorePointer(
                ignoring: state is LoginLoading,
                child: SafeArea(
                  child: Stack(
                    children: [
                      const BottomCurve(),
                      SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: height * 0.05),
                              Image.asset(AssetsImages.hand, height: height * 0.08),
                              SizedBox(height: height * 0.03),
                              Text(
                                'Welcome Back!',
                                style: TextStyle(
                                  fontSize: width * 0.055,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                              CustomTextField(
                                hint: 'Email',
                                icon: Icons.email_outlined,
                                controller: emailController,
                                validator: Validators.email,
                              ),
                              SizedBox(height: height * 0.015),
                              BlocBuilder<PasswordVisibilityCubit, bool>(
                                builder: (context, isVisible) {
                                  return CustomTextField(
                                    hint: 'Password',
                                    icon: Icons.lock_outline,
                                    controller: passwordController,
                                    isPassword: true,
                                    isVisible: isVisible,
                                    validator: Validators.password,
                                    onToggleVisibility: () =>
                                        context.read<PasswordVisibilityCubit>().toggleVisibility(),
                                  );
                                },
                              ),
                              SizedBox(height: height * 0.03),
                              state is LoginLoading
                                  ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                                  : CustomButton(
                                      text: 'Log In',
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          cubit.login(
                                            email: emailController.text.trim(),
                                            password: passwordController.text,
                                          );
                                          // context.pushReplacement(const KidsHomeView());
                                        }
                                      },
                                    ),

                              SizedBox(height: height * 0.03),
                              Row(
                                children: const [
                                  Expanded(child: Divider()),
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: Text('OR')),
                                  Expanded(child: Divider()),
                                ],
                              ),
                              SizedBox(height: height * 0.025),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(color: AppColors.gray, fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.push(const SignUpAsView());
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.04),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
