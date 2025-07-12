import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_loading.dart';
import 'package:save_heaven/core/utils/snack_bar.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:save_heaven/features/auth/presentation/views/reset_password_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bloc.resetState();
    _emailController.addListener(() => setState(() {}));
    _otpController.addListener(() => setState(() {}));
  }

  final bloc = getIt<AuthCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SendOTPLoading) {
            showLoading(context);
          } else if (state is SendOTPFail) {
            context.pop();
            showSnackBar(context, state.message);
          } else if (state is SendOTPSuccess) {
            context.pop();
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text('Forgot Password', style: context.textTheme.titleLarge),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state is SendOTPSuccess
                        ? 'Enter your OTP'
                        : 'Enter your email address to receive  OTP',
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 20),
                  if (state is SendOTPSuccess)
                    CustomTextField(
                      controller: _otpController,
                      hint: 'OTP',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your OTP';
                        }

                        return null;
                      },
                    )
                  else
                    CustomTextField(
                      controller: _emailController,
                      hint: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        final emailRegex = RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        );
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  const SizedBox(height: 20),
                  if (state is SendOTPSuccess)
                    CustomButton(
                      text: 'Submit',
                      onPressed: _otpController.text.trim().isEmpty
                          ? null
                          : () {
                              if (_otpController.text == state.otp.toString()) {
                                context.pushReplacement(
                                  ResetPasswordScreen(
                                    email: _emailController.text.trim(),
                                  ),
                                );
                              } else {
                                showSnackBar(context, 'You entered wrong OTP');
                              }
                            },
                    )
                  else
                    CustomButton(
                      text: 'Send',
                      onPressed: _emailController.text.trim().isEmpty
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                final email = _emailController.text.trim();
                                bloc.sendOTP(email: email);
                              }
                            },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
