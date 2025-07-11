import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_dialog.dart';
import 'package:save_heaven/core/utils/show_loading.dart';
import 'package:save_heaven/shared/features/home/presentation/cubit/home_cubit.dart';

class UpdatePostScreen extends StatefulWidget {
  final bool isRePost;
  final List<String> images;
  final String postId;
  const UpdatePostScreen({
    super.key,
    required this.images,
    required this.postId,
    this.isRePost = false,
  });

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  late final HomeCubit homeBloc;
  final TextEditingController contentController = TextEditingController();
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);
  @override
  void initState() {
    homeBloc = getIt<HomeCubit>();
    contentController.addListener(() {
      isButtonEnabled.value = contentController.text.trim().isNotEmpty;
    });
    super.initState();
  }

  final ImagePicker picker = ImagePicker();

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeBloc,
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeUpdatePostsSuccess || state is HomeRePostSuccess) {
            homeBloc.getPosts(refresh: true);
            context.pop();
            Future.delayed(Duration(milliseconds: 300)).then((_) {
              goBack();
            });
          } else if (state is HomeUpdatePostsFail) {
            context.pop();
            showCustomDialog(
              context,
              title: 'Error while updating post',
              content: state.message,
              confirmText: 'Try again',
              cancelText: '',
              onConfirm: () {
                context.pop();
              },
              onCancel: () {},
            );
          } else if (state is HomeRePostFail) {
            context.pop();
            showCustomDialog(
              context,
              title: 'Error while re-post post',
              content: 'Failed to re-post',
              confirmText: 'Try again',
              cancelText: '',
              onConfirm: () {
                context.pop();
              },
              onCancel: () {},
            );
          } else if (state is HomeUpdatePostsLoading ||
              state is HomeRePostLoading) {
            showLoading(context);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            actions: [
              ValueListenableBuilder(
                valueListenable: isButtonEnabled,
                builder: (context, enable, child) {
                  return ElevatedButton(
                    onPressed: !enable
                        ? null
                        : () {
                            if (widget.isRePost) {
                              homeBloc.rePost(
                                widget.postId,
                                contentController.text.trim(),
                              );
                              return;
                            }
                            homeBloc.updatePosts(
                              widget.postId,
                              contentController.text.trim(),
                            );
                          },
                    child: Text(
                      widget.isRePost ? 'Re-post' : 'save',
                      style: context.textTheme.headlineLarge?.copyWith(
                        color: AppPalette.secondaryTextColor,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(width: 10),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalPagePadding,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: contentController,
                          style: context.textTheme.headlineLarge,
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(),
                            hintText: 'Say something about this post...',
                            hintStyle: context.textTheme.headlineSmall
                                ?.copyWith(color: AppPalette.hintColor),
                          ),
                        ),
                        SizedBox(height: 20),
                        // if (widget.images.isNotEmpty)
                        //   ClipRRect(
                        //     borderRadius: BorderRadius.circular(12),
                        //     child: CachedNetworkImage(
                        //       imageUrl:
                        //           '${ApiEndpoints.imageProvider}${widget.images[0]}',
                        //       fit: BoxFit.contain,
                        //       alignment: Alignment.topCenter,

                        //       width: double.infinity,
                        //       placeholder: (context, url) =>
                        //           Container(color: Colors.grey.shade200),
                        //       errorWidget: (context, url, error) => Container(
                        //         color: Colors.grey.shade300,
                        //         child: const Icon(Icons.broken_image),
                        //       ),
                        //     ),
                        //   ),
                        if (widget.images.isNotEmpty &&
                            widget.images.length > 1) ...[
                          const SizedBox(height: 12),
                          MasonryGridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.images.length,
                            itemBuilder: (context, index) {
                              final image = widget.images[index];
                              final randomHeight = 100 + (index % 4) * 40;

                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          '${ApiEndpoints.imageProvider}$image',
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Center(
                                                    child: Icon(Icons.error),
                                                  ),
                                          fit: BoxFit.cover,
                                          height: randomHeight.toDouble(),
                                          width: double.infinity,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goBack() {
    context.pop();
  }
}
