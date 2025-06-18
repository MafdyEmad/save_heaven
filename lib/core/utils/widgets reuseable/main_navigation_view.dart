import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/curved_bottom_navBar.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_fab.dart';
import 'package:save_heaven/features/donation/presentation/pages/donation_home_page.dart';
import 'package:save_heaven/features/kids/presentation/cubit/navigation%20cubit/navigation_cubit.dart';
import 'package:save_heaven/features/kids/presentation/pages/display_all_kids_view.dart';
import 'package:save_heaven/features/kids/presentation/pages/kids_home_view.dart';
import 'package:save_heaven/features/kids/presentation/pages/orphanage_detail_view.dart';

class MainNavigationView extends StatelessWidget {
  const MainNavigationView({super.key});

  static final List<Widget> pages = [
    const KidsHomeView(),
    const OrphanageDetailView(),
    const DonationHomePage(),
    const DisplayAllKidsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: pages[currentIndex],
          floatingActionButton: const CustomFAB(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const CurvedBottomNavBar(),
        );
      },
    );
  }
}
