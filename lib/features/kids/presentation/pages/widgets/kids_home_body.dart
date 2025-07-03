import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/search_bar.dart';
import 'package:save_heaven/features/kids/data/models/orphanage_near_card_model.dart';
import 'package:save_heaven/features/kids/presentation/cubit/orphanage%20cubit/orphanage_near_cubit.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/awareness_banner.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/orphanage_near_card.dart';

class KidsHomeBody extends StatelessWidget {
  const KidsHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Text(
              //     "kids",
              //     style: TextStyle(
              //       color: AppColors.black,
              //       fontSize: screenWidth * 0.06,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              // SizedBox(height: screenHeight * 0.02),
              const SearchBarWidget(),

              // SizedBox(
              //   height: screenWidth * 0.3,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              //     children: const [
              //       OrphanageCircleItem(title: 'Bethany Children\'s Home', image: 'assets/icons/bethany.png'),
              //       OrphanageCircleItem(title: 'SOS Children\'s Villages', image: 'assets/icons/sos.png'),
              //       OrphanageCircleItem(title: 'Dar Al Orman', image: 'assets/icons/orman.png'),
              //       OrphanageCircleItem(title: 'Mother House', image: 'assets/icons/orman.png'),
              //     ],
              //   ),
              // ),
              const AwarenessBanner(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                child: Text(
                  "Near you",
                  style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
                ),
              ),

              BlocBuilder<OrphanageNearCubit, List<OrphanageNearCardModel>>(
                builder: (context, orphanages) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: 8),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: orphanages.map((model) => OrphanageNearCard(model: model)).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
