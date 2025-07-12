import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_text_field.dart';
import 'package:save_heaven/features/adoption/presentation/pages/adoption_procedures_page.dart';
import 'package:save_heaven/features/ai_search/presentaion/cubit/ai_cubit.dart';

class AiSearchScreen extends StatefulWidget {
  const AiSearchScreen({super.key});

  @override
  State<AiSearchScreen> createState() => _AiSearchScreenState();
}

class _AiSearchScreenState extends State<AiSearchScreen> {
  final query = TextEditingController();
  final bloc = getIt<AiCubit>();
  @override
  void dispose() {
    query.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    query.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('AI Search', style: context.textTheme.titleLarge),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.horizontalPagePadding,
              ),
              child: BlocBuilder<AiCubit, AiState>(
                builder: (context, state) {
                  return IgnorePointer(
                    ignoring: state is AiLoading,
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: 'Search for a kid',
                          maxLines: 4,
                          controller: query,
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: query.text.trim().isEmpty
                              ? null
                              : () {
                                  bloc.aiSearch(query.text.trim());
                                },
                          child: Text(
                            state is AiLoading ? 'Searching...' : 'Search',
                            style: context.textTheme.headlineLarge,
                          ),
                        ),
                        if (state is AiSuccess)
                          Builder(
                            builder: (context) {
                              if (state.children.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No kids found that match your description',
                                    style: context.textTheme.headlineMedium,
                                  ),
                                );
                              } else {
                                return Expanded(
                                  child: ListView.separated(
                                    itemCount: state.children.length,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 20),
                                    itemBuilder: (context, index) {
                                      final child = state.children[index];
                                      return InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                              backgroundColor:
                                                  AppPalette.foregroundColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: SingleChildScrollView(
                                                padding: const EdgeInsets.all(
                                                  24,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    // Profile Image
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            100,
                                                          ),
                                                      child: Image.network(
                                                        ApiEndpoints
                                                                .imageProvider +
                                                            child.image,
                                                        width: 150,
                                                        height: 150,
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (
                                                              context,
                                                              error,
                                                              stackTrace,
                                                            ) => Container(
                                                              width: 150,
                                                              height: 150,
                                                              color: Colors
                                                                  .grey[300],
                                                              child: Icon(
                                                                Icons.person,
                                                                size: 60,
                                                                color: Colors
                                                                    .grey[700],
                                                              ),
                                                            ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16),

                                                    // Name
                                                    Text(
                                                      child.name,
                                                      style: context
                                                          .textTheme
                                                          .headlineMedium
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                    const SizedBox(height: 12),

                                                    // Info Rows
                                                    buildInfoRow(
                                                      Icons.person,
                                                      'Gender',
                                                      child.gender,
                                                      context,
                                                    ),
                                                    buildInfoRow(
                                                      Icons.remove_red_eye,
                                                      'Eye Color',
                                                      child.eyeColor,
                                                      context,
                                                    ),
                                                    buildInfoRow(
                                                      Icons.brush,
                                                      'Skin Tone',
                                                      child.skinTone,
                                                      context,
                                                    ),
                                                    buildInfoRow(
                                                      Icons.palette,
                                                      'Hair Color',
                                                      child.hairColor,
                                                      context,
                                                    ),
                                                    buildInfoRow(
                                                      Icons.face,
                                                      'Hair Style',
                                                      child.hairStyle,
                                                      context,
                                                    ),
                                                    buildInfoRow(
                                                      Icons.public,
                                                      'Religion',
                                                      child.religion,
                                                      context,
                                                    ),
                                                    buildInfoRow(
                                                      Icons.cake,
                                                      'Birthdate',
                                                      child.birthdate
                                                          .toLocal()
                                                          .toString()
                                                          .split(' ')[0],
                                                      context,
                                                    ),
                                                    buildInfoRow(
                                                      Icons.psychology,
                                                      'Personality',
                                                      child.personality,
                                                      context,
                                                    ),
                                                    buildInfoRow(
                                                      Icons.home,
                                                      'Orphanage',
                                                      child.orphanage.name,
                                                      context,
                                                    ),

                                                    const SizedBox(height: 24),

                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: TextButton.icon(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                              context,
                                                            ),
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: AppPalette
                                                              .primaryColor,
                                                        ),
                                                        label: Text(
                                                          'Close',
                                                          style: context
                                                              .textTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                                color: AppPalette
                                                                    .primaryColor,
                                                              ),
                                                        ),
                                                        style: TextButton.styleFrom(
                                                          foregroundColor:
                                                              AppPalette
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          elevation: 4,
                                          color: AppPalette.foregroundColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Photo
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.network(
                                                    ApiEndpoints.imageProvider +
                                                        child.image,
                                                    width: 90,
                                                    height: 90,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) => Container(
                                                          width: 90,
                                                          height: 90,
                                                          color:
                                                              Colors.grey[300],
                                                          child: Icon(
                                                            Icons.person,
                                                            size: 40,
                                                            color: Colors
                                                                .grey[700],
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),

                                                // Info
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        child.name,
                                                        style: context
                                                            .textTheme
                                                            .headlineLarge
                                                            ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                      ),
                                                      const SizedBox(height: 6),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.person,
                                                            size: 16,
                                                            color: AppPalette
                                                                .primaryColor,
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(
                                                            child.gender,
                                                            style: context
                                                                .textTheme
                                                                .headlineMedium,
                                                          ),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          Icon(
                                                            Icons.cake,
                                                            size: 16,
                                                            color: AppPalette
                                                                .primaryColor,
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text(
                                                            '${DateTime.now().difference(child.birthdate).inDays ~/ 365 + 1} yrs',
                                                            style: context
                                                                .textTheme
                                                                .headlineMedium,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        child.personality,
                                                        style: context
                                                            .textTheme
                                                            .headlineMedium
                                                            ?.copyWith(
                                                              color: Colors
                                                                  .grey[600],
                                                            ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 4,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: AppPalette
                                                              .primaryColor
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                        ),
                                                        child: Text(
                                                          child.orphanage.name,
                                                          style: context
                                                              .textTheme
                                                              .headlineMedium
                                                              ?.copyWith(
                                                                color: AppPalette
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),

                                                      // ✅ Adopt button
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: ElevatedButton.icon(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                AppPalette
                                                                    .primaryColor,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    8,
                                                                  ),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            context.push(
                                                              AdoptionProceduresPage(
                                                                child: child,
                                                              ),
                                                            );
                                                          },
                                                          icon: const Icon(
                                                            Icons.favorite,
                                                            color: Colors.white,
                                                          ),
                                                          label: Text(
                                                            'Adopt',
                                                            style: context
                                                                .textTheme
                                                                .headlineMedium
                                                                ?.copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
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
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInfoRow(
    IconData icon,
    String label,
    String value,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppPalette.primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: context.textTheme.headlineMedium?.copyWith(
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
