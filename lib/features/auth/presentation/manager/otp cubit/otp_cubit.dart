import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPCubit extends Cubit<void> {
  OTPCubit() : super(null);

  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  void handleInput(int index, String value, BuildContext context) {
    if (value.isNotEmpty && index < controllers.length - 1) {
      FocusScope.of(context).nextFocus();
    }
  }

  void verifyOTP(BuildContext context) {
    String otp = controllers.map((c) => c.text).join();
    if (otp.length == 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Verifying: \$otp")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter all 4 digits")),
      );
    }
  }

  void resendCode() {
    print("Resending OTP code...");
  }
}
