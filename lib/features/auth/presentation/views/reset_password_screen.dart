import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_loading.dart';
import 'package:save_heaven/core/utils/snack_bar.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:save_heaven/features/auth/presentation/views/login_view.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final bloc = getIt<AuthCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Builder(
        builder: (context) {
          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ResetPasswordLoading) {
                showLoading(context);
              } else if (state is ResetPasswordFail) {
                context.pop();
                showSnackBar(context, state.message);
              } else if (state is ResetPasswordSuccess) {
                context.pushAndRemoveUntil(const LoginView());
                showSnackBar(context, 'Password reset successfully');
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Reset Password',
                  style: context.textTheme.titleLarge,
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPagePadding,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      CustomTextField(
                        controller: passwordController,
                        hint: 'Enter your new password',
                        validator: (p0) {
                          if (p0!.trim().isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: confirmPasswordController,
                        hint: 'Confirm password',
                        validator: (p0) {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            return 'Password does not match';
                          }
                          return null;
                        },
                      ),
                      CustomButton(
                        text: 'Reset Password',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            bloc.resetPassword(
                              password: passwordController.text.trim(),
                              email: widget.email,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
