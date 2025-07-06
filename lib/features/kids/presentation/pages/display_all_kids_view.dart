import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/search_bar.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/display_all_kids_body.dart';

class DisplayAllKidsView extends StatelessWidget {
  const DisplayAllKidsView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: width * 0.03,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.black,
                    ),
                    onPressed: () => context.pop(),
                  ),

                  Expanded(
                    child: Center(
                      child: Text(
                        'Kids',
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.05,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            const SearchBarWidget(),

            const Expanded(child: DisplayAllKidsBody()),
          ],
        ),
      ),
    );
  }
}
