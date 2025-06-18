import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/auth/presentation/manager/Orphanage%20Data%20cubit/orphanage_data_cubit.dart';
import 'package:save_heaven/features/auth/presentation/manager/step%20indicator%20cubit/step_indicator_cubit.dart';
import 'package:save_heaven/features/auth/presentation/widgets/orphanage_data_body.dart';

class OrphanageDataView extends StatelessWidget {
  const OrphanageDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrphanageDataCubit()),
        BlocProvider(create: (_) => StepIndicatorCubit()),
      ],
      child: const Scaffold(body: OrphanageDataBody()),
    );
  }
}
