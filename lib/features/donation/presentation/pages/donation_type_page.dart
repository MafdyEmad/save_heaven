import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/curved_bottom_navBar.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_fab.dart';
import 'package:save_heaven/features/donation/presentation/pages/widgets/donation_type_body.dart';
import 'package:save_heaven/features/kids/presentation/cubit/navigation%20cubit/navigation_cubit.dart';

class DonationTypePage extends StatelessWidget {
  const DonationTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          final width = MediaQuery.of(context).size.width;
          final height = MediaQuery.of(context).size.height;

          return Scaffold(
            backgroundColor: Colors.white,
            body: DonationTypeBody(width: width, height: height),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: const CustomFAB(),
            bottomNavigationBar: CurvedBottomNavBar(),
          );
        },
      ),
    );
  }
}
