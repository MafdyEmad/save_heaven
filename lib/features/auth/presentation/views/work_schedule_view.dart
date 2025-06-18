import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/auth/presentation/manager/Work%20Schedule%20Cubit/work_schedule_cubit.dart';
import 'package:save_heaven/features/auth/presentation/manager/step%20indicator%20cubit/step_indicator_cubit.dart';
import 'package:save_heaven/features/auth/presentation/widgets/work_schedule_body.dart';

class WorkScheduleView extends StatelessWidget {
  const WorkScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WorkScheduleCubit()),
        BlocProvider(create: (_) => StepIndicatorCubit()),
      ],
      child: const Scaffold(body: WorkScheduleBody()),
    );
  }
}
