import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/circle_back_button.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/features/auth/presentation/manager/otp%20cubit/otp_cubit.dart';
import 'package:save_heaven/features/auth/presentation/widgets/components/bottom_curve.dart';

class OTPVerificationBody extends StatelessWidget {
  const OTPVerificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final cubit = context.read<OTPCubit>();

    return SafeArea(
      child: Stack(
        children: [
          const BottomCurve(),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.02),
                const CircleBackButton(),
                SizedBox(height: height * 0.01),
                Text(
                  'OTP',
                  style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height * 0.025),
                CircleAvatar(
                  radius: width * 0.12,
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.mark_email_read_outlined, size: width * 0.1, color: Colors.white),
                ),
                SizedBox(height: height * 0.02),
                const Text("verification code.", style: TextStyle(color: Colors.grey)),
                const Text(
                  "We Send Verification Code To Your Email Id",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "John*******@Gmail.Com.",
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height * 0.03),

                /// OTP Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return Container(
                      width: width * 0.12,
                      height: width * 0.14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: TextFormField(
                        controller: cubit.controllers[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: const TextStyle(fontSize: 20),
                        onChanged: (value) => cubit.handleInput(index, value, context),
                        decoration: const InputDecoration(counterText: '', border: InputBorder.none),
                      ),
                    );
                  }),
                ),
                SizedBox(height: height * 0.04),

                CustomButton(text: 'Verification', onPressed: () => cubit.verifyOTP(context)),
                SizedBox(height: height * 0.015),

                /// Resend Button
                TextButton(
                  onPressed: cubit.resendCode,
                  child: const Text.rich(
                    TextSpan(
                      text: "I Didn't Received The Code? ",
                      style: TextStyle(color: AppColors.grey999, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: "Send Again",
                          style: TextStyle(color: AppColors.grey999, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
