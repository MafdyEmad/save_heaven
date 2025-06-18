import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/assets_images.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/auth/presentation/views/login_view.dart';
import 'package:save_heaven/features/auth/presentation/views/sign_up_as_view.dart';
import '../../../../core/utils/widgets reuseable/custom_button.dart';

class StartJourneyBody extends StatelessWidget {
  const StartJourneyBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.05),
            Image.asset(AssetsImages.hand, height: screenHeight * 0.08, width: screenHeight * 0.08),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Start Your Journey Now',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Join A Caring Community! ',
                style: TextStyle(fontSize: screenWidth * 0.038, color: AppColors.grayTransparent),
                children: [
                  TextSpan(
                    text: 'Donate',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  const TextSpan(text: ' , '),
                  TextSpan(
                    text: 'Adopt',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  const TextSpan(text: ' , '),
                  TextSpan(
                    text: 'Volunteer',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  const TextSpan(text: ', Or Stay Informed.'),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Image.asset(AssetsImages.login, height: screenHeight * 0.3, fit: BoxFit.contain),
            SizedBox(height: screenHeight * 0.05),
            CustomButton(
              text: 'Sign Up',
              onPressed: () {
                context.push(const SignUpAsView());
              },
              width: 320,
              height: 48,
              padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 5),
              borderRadius: 11,
            ),

            SizedBox(height: screenHeight * 0.025),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("have an account? cool!", style: TextStyle(fontSize: screenWidth * 0.035)),
                SizedBox(height: screenHeight * 0.005),
                GestureDetector(
                  onTap: () {
                    context.push(const LoginView());
                  },
                  child: Text(
                    "login now",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
          ],
        ),
      ),
    );
  }
}
