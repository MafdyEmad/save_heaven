import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/search_bar.dart';
import 'package:save_heaven/features/kids/presentation/cubit/orphanage%20cubit/orphanage_near_cubit.dart';
import 'package:save_heaven/features/kids/presentation/cubit/orphanges_cubit.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/kid_profile_card.dart';
import 'package:shimmer/shimmer.dart';

class DisplayAllKidsView extends StatefulWidget {
  final String id;
  const DisplayAllKidsView({super.key, required this.id});

  @override
  State<DisplayAllKidsView> createState() => _DisplayAllKidsViewState();
}

class _DisplayAllKidsViewState extends State<DisplayAllKidsView> {
  final bloc = getIt<OrphanageNearCubit>();
  final states = List.unmodifiable([
    GetAllKidsLoading,
    GetAllKidsError,
    GetAllKidsLoaded,
  ]);
  @override
  void initState() {
    bloc.getAllKids(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocProvider.value(
      value: bloc,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Kids',
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.05,
                ),
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPagePadding,
                ),
                child: BlocBuilder<OrphanageNearCubit, OrphangesState>(
                  buildWhen: (previous, current) =>
                      states.contains(current.runtimeType),
                  builder: (context, state) {
                    if (state is GetAllKidsError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: context.textTheme.headlineLarge,
                        ),
                      );
                    }
                    if (state is GetAllKidsLoading) {
                      return ListView.separated(
                        itemBuilder: (context, index) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: double.infinity,
                            height: 80,
                            color: Colors.white,
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20),
                        itemCount: 10,
                      );
                    }
                    if (state is GetAllKidsLoaded) {
                      if (state.children.isEmpty) {
                        return Center(
                          child: Text(
                            'No kids found',
                            style: context.textTheme.headlineLarge,
                          ),
                        );
                      }
                      return Column(
                        children: [
                          const SearchBarWidget(),

                          Expanded(
                            child: ListView.builder(
                              itemCount: state.children.length,
                              itemBuilder: (context, index) {
                                return KidProfileCard(
                                  kid: state.children[index],
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
