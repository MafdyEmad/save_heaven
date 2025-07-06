import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/kids/presentation/cubit/orphanage%20cubit/orphanage_near_cubit.dart';
import 'package:save_heaven/features/kids/presentation/cubit/orphanges_cubit.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/awareness_banner.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/orphanage_near_card.dart';
import 'package:shimmer/shimmer.dart';

class KidsHomeBody extends StatefulWidget {
  const KidsHomeBody({super.key});

  @override
  State<KidsHomeBody> createState() => _KidsHomeBodyState();
}

class _KidsHomeBodyState extends State<KidsHomeBody> {
  final bloc = getIt<OrphanageNearCubit>();
  Timer? _timer;
  final states = List.unmodifiable([
    OrphangesLoading,
    OrphangesError,
    OrphangesLoaded,
  ]);
  @override
  void initState() {
    bloc.getOrphanages();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List filterData = [];
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPagePadding,
            ),
            child: BlocBuilder<OrphanageNearCubit, OrphangesState>(
              buildWhen: (previous, current) =>
                  states.contains(current.runtimeType),
              builder: (context, state) {
                if (state is OrphangesLoading) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: 6,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: double.infinity,
                        height: 80,
                        color: Colors.white,
                      ),
                    ),
                  );
                } else if (state is OrphangesError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: context.textTheme.headlineLarge,
                    ),
                  );
                } else if (state is OrphangesLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      CustomTextField(
                        hint: 'Search...',
                        controller: search,
                        onChanged: (p0) {
                          _timer?.cancel();
                          _timer = Timer(const Duration(milliseconds: 500), () {
                            setState(() {
                              filterData = state.orphanagesResponse.data
                                  .where(
                                    (element) => element.name
                                        .toLowerCase()
                                        .contains(p0.toLowerCase()),
                                  )
                                  .toList();
                            });
                          });
                        },
                      ),
                      const AwarenessBanner(),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: 8,
                        ),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: .8,
                              ),
                          shrinkWrap: true,
                          itemCount:
                              filterData.isNotEmpty && search.text.isNotEmpty
                              ? filterData.length
                              : state.orphanagesResponse.data.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => OrphanageNearCard(
                            orphanage: state.orphanagesResponse.data[index],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
