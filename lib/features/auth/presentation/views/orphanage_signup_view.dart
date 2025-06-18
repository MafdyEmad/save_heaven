import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/features/auth/presentation/cubit/auth_cubit.dart';
import '../widgets/orphanage_signup_body.dart';

class OrphanageSignupView extends StatelessWidget {
  const OrphanageSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: const Scaffold(body: OrphanageSignupBody()),
    );
  }
}
