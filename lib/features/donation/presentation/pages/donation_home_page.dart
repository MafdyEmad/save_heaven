import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/donation/presentation/cubit/donation_cubit.dart';
import 'package:save_heaven/features/donation/presentation/pages/widgets/components/orphanage_card.dart';
import 'package:shimmer/shimmer.dart';

class DonationHomePage extends StatefulWidget {
  const DonationHomePage({super.key});

  @override
  State<DonationHomePage> createState() => _DonationHomePageState();
}

class _DonationHomePageState extends State<DonationHomePage> {
  final bloc = getIt<DonationCubit>();
  @override
  void initState() {
    bloc.getOrphanage();
    super.initState();
  }

  Timer? _timer;
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List filterData = [];
  final search = TextEditingController();
  final states = List.unmodifiable([
    DonationGetOrphanageLoading,
    DonationGetOrphanageFail,
    DonationGetOrphanageSuccess,
  ]);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<DonationCubit, DonationState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Donation', style: context.textTheme.titleLarge),
            ),
            body: Builder(
              builder: (context) {
                if (state is DonationGetOrphanageLoading) {
                  return GridView.builder(
                    padding: EdgeInsets.all(width * 0.03),
                    itemCount: 10,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: width * 0.03,
                      mainAxisSpacing: width * 0.03,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (_, index) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                  );
                }
                if (state is DonationGetOrphanageFail) {
                  return Center(
                    child: Text(
                      state.message,
                      style: context.textTheme.headlineLarge,
                    ),
                  );
                }
                if (state is DonationGetOrphanageSuccess) {
                  return Column(
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
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.horizontalPagePadding,
                        ),
                        child: CustomTextField(
                          hint: 'Search...',
                          controller: search,
                          onChanged: (p0) {
                            _timer?.cancel();
                            _timer = Timer(
                              const Duration(milliseconds: 500),
                              () {
                                setState(() {
                                  filterData = state.orphanagesResponse.data
                                      .where(
                                        (element) => element.name
                                            .toLowerCase()
                                            .contains(p0.toLowerCase()),
                                      )
                                      .toList();
                                });
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: width * 0.01),
                      if (filterData.isEmpty && search.text.isNotEmpty)
                        Center(
                          child: Text(
                            "No Orphanages Found",
                            style: context.textTheme.headlineLarge,
                          ),
                        )
                      else
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.all(width * 0.03),
                            itemCount:
                                filterData.isNotEmpty && search.text.isNotEmpty
                                ? filterData.length
                                : state.orphanagesResponse.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: width * 0.03,
                                  mainAxisSpacing: width * 0.03,
                                  childAspectRatio: 0.75,
                                ),
                            itemBuilder: (_, index) => OrphanageCard(
                              model: state.orphanagesResponse.data[index],
                            ),
                          ),
                        ),
                    ],
                  );
                }
                return SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
