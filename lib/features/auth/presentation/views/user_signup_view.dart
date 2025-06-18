import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:save_heaven/features/auth/presentation/manager/Password%20Visibility%20Cubit/password_visibility_cubit.dart';
import 'package:save_heaven/features/auth/presentation/widgets/user_signup_body.dart';

class UserSignupView extends StatelessWidget {
  const UserSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: UserSignupBody());
  }
}
