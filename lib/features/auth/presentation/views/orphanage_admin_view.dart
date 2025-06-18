import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/auth/data/data_scource/auth_remote_data_source.dart';
import 'package:save_heaven/features/auth/presentation/manager/orphanage%20admin%20cubit/orphanage_admin_cubit.dart';
import 'package:save_heaven/features/auth/presentation/manager/step%20indicator%20cubit/step_indicator_cubit.dart';
import 'package:save_heaven/features/auth/presentation/widgets/orphanage_admin_body.dart';

class OrphanageAdminView extends StatelessWidget {
  final OrphanageSignUpParams currentParams;
  const OrphanageAdminView({super.key, required this.currentParams});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrphanageAdminCubit()),
        BlocProvider(create: (_) => StepIndicatorCubit()),
      ],
      child: Scaffold(body: OrphanageAdminBody(currentParams: currentParams)),
    );
  }
}
