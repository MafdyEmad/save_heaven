import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/kids/presentation/cubit/navigation%20cubit/navigation_cubit.dart';
import 'package:save_heaven/features/kids/presentation/cubit/orphanage%20cubit/orphanage_near_cubit.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/kids_home_body.dart';

class KidsHomeView extends StatelessWidget {
  const KidsHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OrphanageNearCubit()..loadOrphanages()),
        BlocProvider(create: (_) => NavigationCubit()..changeTab(1)),
      ],
      child: const KidsHomeBody(),
    );
  }
}
