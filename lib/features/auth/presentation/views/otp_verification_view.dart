import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/auth/presentation/manager/otp%20cubit/otp_cubit.dart';
import 'package:save_heaven/features/auth/presentation/widgets/otp_verification_body.dart';

class OTPVerificationView extends StatelessWidget {
  const OTPVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OTPCubit(),
      child: const Scaffold(body: OTPVerificationBody()),
    );
  }
}
