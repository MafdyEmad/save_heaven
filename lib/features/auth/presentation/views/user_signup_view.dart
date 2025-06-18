import 'package:flutter/material.dart';
import 'package:save_heaven/features/auth/presentation/widgets/user_signup_body.dart';

class UserSignupView extends StatelessWidget {
  const UserSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: UserSignupBody());
  }
}
