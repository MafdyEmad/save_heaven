import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_loading.dart';
import 'package:save_heaven/core/utils/snack_bar.dart';
import 'package:save_heaven/features/adoption/presentation/pages/adoption_procedures_page.dart';
import 'package:save_heaven/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:save_heaven/features/profile/presentation/screens/add_orphan_screen.dart';
import 'package:shimmer/shimmer.dart';

class OurKidsScreen extends StatefulWidget {
  final String id;
  final bool isMyAccount;
  const OurKidsScreen({super.key, required this.id, required this.isMyAccount});

  @override
  State<OurKidsScreen> createState() => _OurKidsScreenState();
}

class _OurKidsScreenState extends State<OurKidsScreen> {
  final profileCubit = getIt<ProfileCubit>();
  @override
  void initState() {
    profileCubit.getOurKids(widget.id);
    super.initState();
  }

  final states = List.unmodifiable([
    GetOurKidsLoading,
    GetOurKidsSuccess,
    GetOurKidsFail,
  ]);
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profileCubit,
      child: Builder(
        builder: (context) {
          return Scaffold(
            floatingActionButton: widget.isMyAccount
                ? FloatingActionButton(
                    backgroundColor: AppPalette.primaryColor,
                    child: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      context.push(AddOrphanScreen(id: widget.id));
                    },
                  )
                : null,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Our Kids', style: context.textTheme.titleLarge),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPagePadding,
              ),
              child: BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is DeleteSuccess) {
                    context.pop();
                    showSnackBar(context, 'Kid deleted successfully');
                    profileCubit.getOurKids(widget.id);
                  } else if (state is DeleteFail) {
                    context.pop();
                    showSnackBar(context, state.message);
                  } else if (state is DeleteLoading) {
                    showLoading(context);
                  }
                },
                buildWhen: (previous, current) =>
                    states.contains(current.runtimeType),
                builder: (context, state) {
                  if (state is GetOurKidsLoading) {
                    return GridView.builder(
                      itemCount: 10,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppDimensions.horizontalPagePadding,
                        mainAxisSpacing: AppDimensions.horizontalPagePadding,
                      ),
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
                  }
                  if (state is GetOurKidsFail) {
                    return Center(
                      child: Text(
                        state.message,
                        style: context.textTheme.headlineLarge,
                      ),
                    );
                  }
                  if (state is GetOurKidsSuccess) {
                    final children = state.children;
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: AppPalette.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Total children: ${children.length}',
                            style: context.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        if (children.isEmpty)
                          Expanded(
                            child: Center(
                              child: Text(
                                'No kids yet',
                                style: context.textTheme.headlineLarge,
                              ),
                            ),
                          )
                        else
                          Expanded(
                            child: GridView.builder(
                              itemCount: children.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing:
                                        AppDimensions.horizontalPagePadding,
                                    mainAxisSpacing:
                                        AppDimensions.horizontalPagePadding,
                                    childAspectRatio: .7,
                                  ),
                              itemBuilder: (context, index) {
                                final child = children[index];
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            alignment: Alignment(0, .1),
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                ApiEndpoints.imageProvider +
                                                child.image,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                                      Icons.person,
                                                      size: 50,
                                                    ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        child.name,
                                        style: context.textTheme.headlineLarge,
                                      ),

                                      if (widget.isMyAccount) ...[
                                        ElevatedButton(
                                          onPressed: () {
                                            context.push(
                                              AddOrphanScreen(
                                                kid: state.children[index],
                                                id: widget.id,
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Edit info',
                                            style: context
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(color: Colors.white),
                                          ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            profileCubit.deleteKid(
                                              state.children[index].id,
                                            );
                                          },
                                          child: Text(
                                            'Delete',
                                            style:
                                                context.textTheme.headlineSmall,
                                          ),
                                        ),
                                      ] else ...[
                                        ElevatedButton(
                                          onPressed: () {
                                            context.push(
                                              AdoptionProceduresPage(
                                                child: state.children[index],
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Adopt',
                                            style: context
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                );
                              },
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
          );
        },
      ),
    );
  }
}
