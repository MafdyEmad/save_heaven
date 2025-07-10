import 'package:flutter/material.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';

import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/orphanage_dontaion/presentation/screens/adoptions_requests_screen.dart';
import 'package:save_heaven/features/orphanage_dontaion/presentation/screens/donation_receipts_scree.dart';

class OrphanageRequestsScreenAndDonationsState extends StatefulWidget {
  const OrphanageRequestsScreenAndDonationsState({super.key});

  @override
  State<OrphanageRequestsScreenAndDonationsState> createState() =>
      _OrphanageRequestsScreenAndDonationsState();
}

class _OrphanageRequestsScreenAndDonationsState
    extends State<OrphanageRequestsScreenAndDonationsState> {
  final List<Widget> screens = List.unmodifiable([
    AdoptionsRequestsScreen(),
    DonationReceiptsScree(),
  ]);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.only(
                right: AppDimensions.horizontalPagePadding,
                left: AppDimensions.horizontalPagePadding,
                top: 18,
              ),
              child: Column(
                children: [
                  TabBar(
                    labelStyle: context.textTheme.headlineMedium,
                    dividerColor: Colors.transparent,
                    indicatorColor: Color(0xfffcd06b),
                    tabs: [
                      Tab(text: 'Adoption Requests'),
                      Tab(text: 'Donation Receipts'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(child: TabBarView(children: screens)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
