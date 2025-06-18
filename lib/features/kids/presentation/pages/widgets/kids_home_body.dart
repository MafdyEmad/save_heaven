import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/curved_bottom_navBar.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_fab.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/search_bar.dart';
import 'package:save_heaven/features/kids/data/models/orphanage_near_card_model.dart';
import 'package:save_heaven/features/kids/presentation/cubit/navigation%20cubit/navigation_cubit.dart';
import 'package:save_heaven/features/kids/presentation/cubit/orphanage%20cubit/orphanage_near_cubit.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/awareness_banner.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/orphanage_circle_item.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/orphanage_near_card.dart';

class KidsHomeBody extends StatelessWidget {
  const KidsHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.025),
                Center(
                  child: Text(
                    "kids",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const SearchBarWidget(),

                SizedBox(
                  height: screenWidth * 0.3,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    children: const [
                      OrphanageCircleItem(
                        title: 'Bethany Children\'s Home',
                        image: 'assets/icons/bethany.png',
                      ),
                      OrphanageCircleItem(title: 'SOS Children\'s Villages', image: 'assets/icons/sos.png'),
                      OrphanageCircleItem(title: 'Dar Al Orman', image: 'assets/icons/orman.png'),
                      OrphanageCircleItem(title: 'Mother House', image: 'assets/icons/orman.png'),
                    ],
                  ),
                ),

                const AwarenessBanner(),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: Text(
                    "Near you",
                    style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
                  ),
                ),

                Expanded(
                  child: BlocBuilder<OrphanageNearCubit, List<OrphanageNearCardModel>>(
                    builder: (context, orphanages) {
                      return GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: 8),
                        itemCount: orphanages.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (_, index) => OrphanageNearCard(model: orphanages[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: const CustomFAB(),
          bottomNavigationBar: CurvedBottomNavBar(
            // currentIndex: currentIndex,
          ),
        );
      },
    );
  }
}
