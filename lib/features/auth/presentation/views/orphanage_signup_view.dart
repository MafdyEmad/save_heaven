import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/orphanage signup cubit/orphanage_signup_cubit.dart';
import '../widgets/orphanage_signup_body.dart';
import '../manager/Password Visibility Cubit/password_visibility_cubit.dart';

class OrphanageSignupView extends StatelessWidget {
  const OrphanageSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrphanageSignupCubit()),
        BlocProvider(create: (_) => PasswordVisibilityCubit()),
      ],
      child: const Scaffold(
        body: OrphanageSignupBody(),
      ),
    );
  }
}
