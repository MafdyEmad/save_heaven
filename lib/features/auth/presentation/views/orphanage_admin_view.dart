import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/auth/presentation/manager/orphanage%20admin%20cubit/orphanage_admin_cubit.dart';
import 'package:save_heaven/features/auth/presentation/manager/step%20indicator%20cubit/step_indicator_cubit.dart';
import 'package:save_heaven/features/auth/presentation/widgets/orphanage_admin_body.dart';

class OrphanageAdminView extends StatelessWidget {
  const OrphanageAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrphanageAdminCubit()),
        BlocProvider(create: (_) => StepIndicatorCubit()),
      ],
      child: const Scaffold(body: OrphanageAdminBody()),
    );
  }
}
