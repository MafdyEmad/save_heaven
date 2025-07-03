import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';

import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/orphanage_dontaion/presentation/cubit/orphanage_donation_state_cubit.dart';
import 'package:save_heaven/features/orphanage_dontaion/presentation/screens/adoptions_requests_screen.dart';
import 'package:save_heaven/features/orphanage_dontaion/presentation/screens/donation_receipts_scree.dart';

class OrphanageRequestsScreen extends StatefulWidget {
  const OrphanageRequestsScreen({super.key});

  @override
  State<OrphanageRequestsScreen> createState() =>
      _OrphanageRequestsScreenState();
}

class _OrphanageRequestsScreenState extends State<OrphanageRequestsScreen> {
  final List<Widget> screens = List.unmodifiable([
    AdoptionsRequestsScreen(),
    DonationReceiptsScree(),
  ]);
  final bloc = getIt<OrphanageDonationCubit>();
  @override
  void initState() {
    // bloc.getRequests();
    bloc.getDonationItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Builder(
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
      ),
    );
  }
}
