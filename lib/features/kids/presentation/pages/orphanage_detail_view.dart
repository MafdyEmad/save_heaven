import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/kids/presentation/cubit/navigation%20cubit/navigation_cubit.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/orphanage_detail_body.dart';

class OrphanageDetailView extends StatelessWidget {
  const OrphanageDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => NavigationCubit()..changeTab(1), child: const OrphanageDetailBody());
  }
}
