import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/curved_bottom_navBar.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_fab.dart';
import 'package:save_heaven/features/kids/presentation/cubit/Filter%20cubit/filter_cubit.dart';
import 'package:save_heaven/features/kids/presentation/cubit/navigation%20cubit/navigation_cubit.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/kids_filter_body.dart';

class KidsFilterView extends StatelessWidget {
  const KidsFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FilterCubit()),
        BlocProvider(create: (_) => NavigationCubit()..changeTab(1)),
      ],
      child: const FilterScaffoldWithBottomNav(),
    );
  }
}

class FilterScaffoldWithBottomNav extends StatelessWidget {
  const FilterScaffoldWithBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<NavigationCubit>().state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: const FilterBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const CustomFAB(),
      bottomNavigationBar: CurvedBottomNavBar(
        // currentIndex: currentIndex,
      ),
    );
  }
}
