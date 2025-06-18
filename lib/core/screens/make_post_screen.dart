import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_dialog.dart';
import 'package:save_heaven/core/utils/widgets%20reuseable/custom_button.dart';
import 'package:save_heaven/core/widgets/custom_button.dart';
import 'package:save_heaven/shared/features/home/presentation/cubit/home_cubit.dart';

class MakePostScreen extends StatefulWidget {
  final String name;
  final String image;
  const MakePostScreen({super.key, required this.name, required this.image});

  @override
  State<MakePostScreen> createState() => _MakePostScreenState();
}

class _MakePostScreenState extends State<MakePostScreen> {
  final postFocusNode = FocusNode();
  late final HomeCubit homeBloc;
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    homeBloc = getIt<HomeCubit>();
    postFocusNode.requestFocus();
    super.initState();
  }

  final ImagePicker picker = ImagePicker();

  @override
  void dispose() {
    contentController.dispose();
    postFocusNode.dispose();
    super.dispose();
  }

  final List<File> imagesToPost = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeBloc,
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeMakePostsSuccess) {
            homeBloc.getPosts(refresh: true);
            context.pop();
            Future.delayed(Duration(milliseconds: 300)).then((_) {
              goBack();
            });
          } else if (state is HomeMakePostsFail) {
            context.pop();
            showCustomDialog(
              context,
              title: 'Error while making post',
              content: state.message,
              confirmText: 'Try again',
              cancelText: '',
              onConfirm: () {
                context.pop();
              },
              onCancel: () {},
            );
          } else if (state is HomeMakePostsLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => PopScope(
                canPop: false,
                child: AlertDialog(
                  backgroundColor: Colors.transparent,
                  content: Center(child: CircularProgressIndicator(color: AppPalette.primaryColor)),
                ),
              ),
            );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPagePadding),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: widget.image,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(widget.name, style: context.textTheme.headlineMedium),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: contentController,
                          focusNode: postFocusNode,
                          style: context.textTheme.headlineLarge,
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(),
                            hintText: 'What\'s happening?',
                            hintStyle: context.textTheme.headlineSmall?.copyWith(color: AppPalette.hintColor),
                          ),
                        ),

                        if (imagesToPost.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          MasonryGridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: imagesToPost.length,
                            itemBuilder: (context, index) {
                              final image = imagesToPost[index];
                              final randomHeight = 100 + (index % 4) * 40;

                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(opacity: animation, child: child);
                                },
                                child: Container(
                                  key: ValueKey(image.path),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          File(image.path),
                                          fit: BoxFit.cover,
                                          height: randomHeight.toDouble(),
                                          width: double.infinity,
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withAlpha(150),
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                imagesToPost.removeAt(index);
                                              });
                                            },
                                            icon: const Icon(Icons.close, color: Colors.white, size: 18),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                          ),
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
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                final image = await picker.pickImage(source: ImageSource.camera);
                                if (image != null) {
                                  setState(() {
                                    imagesToPost.add(File(image.path));
                                  });
                                }
                              },
                              icon: const Icon(Icons.camera_alt_outlined),
                            ),
                            IconButton(
                              onPressed: () async {
                                final images = await picker.pickMultiImage();
                                if (images.isNotEmpty) {
                                  for (final image in images) {
                                    imagesToPost.add(File(image.path));
                                  }
                                  setState(() {});
                                }
                              },
                              icon: const Icon(Icons.image_outlined),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'everyone can reply & repost',
                      style: context.textTheme.headlineSmall?.copyWith(color: AppPalette.hintColor),
                    ),
                    const Spacer(),
                    CustomButton(
                      onPressed: () {
                        homeBloc.makePosts(content: contentController.text.trim(), images: imagesToPost);
                      },
                      text: 'Post',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
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
