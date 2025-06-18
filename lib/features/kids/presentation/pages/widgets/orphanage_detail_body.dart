import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/kids/data/models/kid_model.dart';
import 'package:save_heaven/features/kids/presentation/cubit/navigation%20cubit/navigation_cubit.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/curved_bottom_navBar.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_fab.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/kid_card.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/search_bar.dart';

class OrphanageDetailBody extends StatelessWidget {
  const OrphanageDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final kids = [
      KidModel(
        name: "mody",
        age: 11,
        gender: "male",
        hairType: "straight-haired",
        religion: "muslim",
        educationLevel: "primary educated",
        imageUrl: "assets/images/kid1.png",
        orphanageIcon: "assets/icons/bethany.png",
      ),
      KidModel(
        name: "hamody",
        age: 12,
        gender: "male",
        hairType: "curly-haired",
        religion: "christian",
        educationLevel: "middle educated",
        imageUrl: "assets/images/kid1.png",
        orphanageIcon: "assets/icons/bethany.png",
      ),
      KidModel(
        name: "jojo",
        age: 10,
        gender: "female",
        hairType: "curly-haired",
        religion: "muslim",
        educationLevel: "primary educated",
        imageUrl: "assets/images/kid1.png",
        orphanageIcon: "assets/icons/bethany.png",
      ),
    ];

    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
                  onPressed: () => context.pop(),
                ),
                Center(child: Image.asset("assets/icons/bethany.png", height: screenWidth * 0.15)),
                const SizedBox(height: 6),
                const Center(
                  child: Text(
                    "Bethany Children's Home",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 4),
                const Center(
                  child: Text(
                    "Our angels are waiting for a touch of warmth and tenderness.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 16),
                const SearchBarWidget(),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: kids.length,
                    itemBuilder: (context, index) => KidCard(kid: kids[index]),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: const CustomFAB(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: CurvedBottomNavBar(),
        );
      },
    );
  }
}
