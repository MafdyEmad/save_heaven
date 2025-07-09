import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/assets_images.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/circle_back_button.dart';
import 'package:save_heaven/features/auth/presentation/views/orphanage_signup_view.dart';
import 'package:save_heaven/features/auth/presentation/views/user_signup_view.dart';
import '../../../../core/utils/widgets reuseable/custom_button.dart';

class SignUpAsBody extends StatelessWidget {
  const SignUpAsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.03),
            const CircleBackButton(),
            SizedBox(height: height * 0.02),
            Center(
              child: Image.asset(AssetsImages.hand, height: height * 0.08),
            ),
            SizedBox(height: height * 0.025),
            Center(
              child: Text(
                'Sign Up As',
                style: TextStyle(
                  fontSize: width * 0.055,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
            SizedBox(height: height * 0.05),
            CustomButton(
              text: 'Orphanage',
              onPressed: () {
                context.push(OrphanageSignupView());
              },
            ),
            SizedBox(height: height * 0.01),
            CustomButton(
              text: 'Donor',
              onPressed: () {
                context.push(UserSignupView());
              },
            ),
            // SizedBox(height: height * 0.01),
            // CustomButton(
            //   text: 'Guest',
            //   onPressed: () {
            //     context.push(UserSignupView());
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
