import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/curved_bottom_navBar.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_fab.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/search_bar.dart';
import 'package:save_heaven/features/donation/data/models/orphanage_model.dart';
import 'package:save_heaven/features/donation/presentation/cubit/donation_cubit.dart';
import 'package:save_heaven/features/donation/presentation/pages/widgets/components/orphanage_card.dart';
import 'package:save_heaven/features/kids/presentation/cubit/navigation%20cubit/navigation_cubit.dart';

class DonationHomePage extends StatelessWidget {
  const DonationHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DonationCubit()..loadOrphanages()),
        BlocProvider(create: (_) => NavigationCubit()),
      ],
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Donation', style: context.textTheme.titleLarge),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Donate to Orphan Sponsorship Projects",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.04,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.06,
                    vertical: width * 0.01,
                  ),
                  child: Text(
                    "You can contribute by donating from inside or outside Egypt through text messages, or credit cards.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: width * 0.035,
                    ),
                  ),
                ),
                const SearchBarWidget(),
                SizedBox(height: width * 0.01),
                Expanded(
                  child: BlocBuilder<DonationCubit, List<OrphanageModel>>(
                    builder: (context, orphanages) {
                      int crossAxisCount = width > 700
                          ? 4
                          : width > 500
                          ? 3
                          : 2;

                      return GridView.builder(
                        padding: EdgeInsets.all(width * 0.03),
                        itemCount: orphanages.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: width * 0.03,
                          mainAxisSpacing: width * 0.03,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (_, index) =>
                            OrphanageCard(model: orphanages[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
