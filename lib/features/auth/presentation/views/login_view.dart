import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/auth/presentation/manager/Password%20Visibility%20Cubit/password_visibility_cubit.dart';
import '../widgets/login_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordVisibilityCubit(),
      child: Scaffold(resizeToAvoidBottomInset: false, body: LoginBody()),
    );
  }
}
