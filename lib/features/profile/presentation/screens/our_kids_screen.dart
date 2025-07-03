import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/features/profile/presentation/cubit/profile_cubit.dart';

class OurKidsScreen extends StatefulWidget {
  final String id;
  const OurKidsScreen({super.key, required this.id});

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
            appBar: AppBar(
              centerTitle: true,
              title: Text('Our Kids', style: context.textTheme.titleLarge),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPagePadding,
              ),
              child: BlocBuilder<ProfileCubit, ProfileState>(
                buildWhen: (previous, current) =>
                    states.contains(current.runtimeType),
                builder: (context, state) => Column(
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
                        'total children capacity: 330',
                        style: context.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppDimensions.horizontalPagePadding,
                          mainAxisSpacing: AppDimensions.horizontalPagePadding,
                        ),
                        itemBuilder: (context, index) => Container(
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
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CachedNetworkImage(
                                    alignment: Alignment(0, .1),
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.person, size: 50),
                                  ),
                                ),
                              ),
                              Text(
                                'mody',
                                style: context.textTheme.headlineLarge,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Edit info',
                                  style: context.textTheme.headlineSmall
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
