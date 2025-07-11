import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:like_button/like_button.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/hive/adapters/user_adapter/user_hive.dart';
import 'package:save_heaven/core/hive/hive_boxes/hive_boxes.dart';
import 'package:save_heaven/core/screens/update_post_screen.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_dialog.dart';
import 'package:save_heaven/core/utils/show_loading.dart';
import 'package:save_heaven/core/utils/snack_bar.dart';
import 'package:save_heaven/core/widgets/custom_pop_menu.dart';
import 'package:save_heaven/core/widgets/custom_refresh.dart';
import 'package:save_heaven/core/widgets/make_post_widget.dart';
import 'package:save_heaven/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:save_heaven/shared/features/home/data/models/post_response.dart';
import 'package:save_heaven/shared/features/home/presentation/cubit/home_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit homeCubit;
  final String token = HiveBoxes.secureBox.getAt(0);
  late final UserHive user;
  final notificationBloc = getIt<NotificationCubit>();
  final postsBox = HiveBoxes.postsBox;
  @override
  void initState() {
    homeCubit = getIt<HomeCubit>()..getPosts();

    final userId = JwtDecoder.decode(token)['userId'];
    user = HiveBoxes.userBox.get(userId);
    super.initState();
  }

  final homeGetPostsStates = List.unmodifiable([
    HomeGetPostsSuccess,
    HomeGetPostsLoading,
    HomeGetPostsFail,
  ]);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeCubit,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.horizontalPagePadding,
          ),
          child: Builder(
            builder: (context) {
              return BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  // if (state is HomeRePostSuccess) {
                  //   context.pop();
                  //   homeCubit.getPosts(refresh: true);
                  // }
                  // if (state is HomeRePostFail) {
                  //   context.pop();
                  //   showCustomDialog(
                  //     context,
                  //     title: 'Error while re-post post',
                  //     content: 'Failed to re-post',
                  //     confirmText: 'Try again',
                  //     cancelText: '',
                  //     onConfirm: () {
                  //       context.pop();
                  //     },
                  //     onCancel: () {},
                  //   );
                  // }
                  // if (state is HomeRePostLoading) {
                  //   showLoading(context);
                  // }

                  if (state is HomeDeletePostsSuccess) {
                    context.pop();
                    homeCubit.getPosts(refresh: true);
                  } else if (state is HomeDeletePostsFail) {
                    context.pop();
                    showSnackBar(context, 'Failed to delete your post');
                  } else if (state is HomeDeletePostsLoading) {
                    showLoading(context);
                  }
                },
                buildWhen: (previous, current) =>
                    homeGetPostsStates.contains(current.runtimeType),
                builder: (context, state) {
                  if (state is HomeGetPostsLoading) {
                    return ListView.separated(
                      itemBuilder: (context, index) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: double.infinity,
                          height: 250,
                          color: Colors.white,
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20),
                      itemCount: 10,
                    );
                  }
                  if (state is HomeGetPostsFail) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            state.message,
                            style: context.textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TextButton(
                          onPressed: () => homeCubit.getPosts(refresh: true),
                          child: Text(
                            'Try again',
                            style: context.textTheme.headlineMedium?.copyWith(
                              color: AppPalette.primaryColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  final posts = (state as HomeGetPostsSuccess).posts;
                  return CustomRefresh(
                    onRefresh: () async {
                      homeCubit.getPosts(refresh: true);
                      notificationBloc.getUnreadNotificationsCount();
                    },
                    child: ListView.separated(
                      padding: EdgeInsets.only(bottom: 20.h),
                      itemCount: posts.posts.length + 1,
                      separatorBuilder: (context, index) =>
                          index == 0 ? SizedBox.shrink() : Divider(height: 30),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return MakePostWidget(
                            image: ApiEndpoints.imageProvider + user.image!,
                            name: user.name,
                          );
                        }
                        final post = posts.posts[index - 1];
                        return _buildPost(post);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPost(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ClipOval(
            child: CachedNetworkImage(
              imageUrl: ApiEndpoints.imageProvider + post.user.image,
              width: 50.w,
              height: 50.w,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => const Icon(Icons.person),
            ),
          ),
          trailing: GestureDetector(
            onTapDown: (details) =>
                _showPostOptions(details.globalPosition, post),
            child: const Icon(Icons.more_horiz, color: Colors.grey),
          ),
          title: Text(post.user.name, style: context.textTheme.headlineMedium),
          subtitle: Text(
            DateTime.now().difference(post.createdAt).inDays == 0
                ? timeago.format(post.createdAt)
                : DateFormat('yyyy-MM-dd').format(post.createdAt),
            style: context.textTheme.headlineSmall,
          ),
        ),
        if (didRePost(post))
          Text(post.content, style: context.textTheme.headlineLarge),
        _buildPostContent(post),
        _buildPostActions(post),
      ],
    );
  }

  Widget _buildPostContent(Post post) {
    final repostedFromImage = post.repostedFrom == null
        ? ''
        : post.repostedFrom!.user.image;
    return Container(
      decoration: !didRePost(post)
          ? null
          : BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: didRePost(post)
          ? const EdgeInsets.all(10)
          : const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (didRePost(post))
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: ApiEndpoints.imageProvider + repostedFromImage,
                      width: 50.w,
                      height: 50.w,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const Icon(Icons.person),
                    ),
                  ),
                  title: Text(
                    post.repostedFrom!.user.name,
                    style: context.textTheme.headlineMedium,
                  ),
                  subtitle: Text(
                    DateTime.now().difference(post.createdAt).inDays == 0
                        ? timeago.format(post.createdAt)
                        : DateFormat('yyyy-MM-dd').format(post.createdAt),
                    style: context.textTheme.headlineSmall,
                  ),
                ),

              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: (didRePost(post)) ? 10 : 0,
                ),
                child: ExpandableText(
                  didRePost(post) ? post.repostedFrom!.content : post.content,
                  expandText: 'Read More',
                  collapseText: 'Read Less',
                  animation: true,
                  maxLines: 8,
                  style: context.textTheme.headlineMedium,
                  linkColor: AppPalette.primaryColor,
                ),
              ),
            ],
          ),
          if (post.images.isNotEmpty)
            if (post.images.length == 1)
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black,
                      builder: (_) {
                        return Dialog(
                          backgroundColor: Colors.black,
                          insetPadding: EdgeInsets.zero,
                          child: ImagePreviewDialog(
                            images: [post.images[0]],
                            initialIndex: 0,
                          ),
                        );
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl:
                          '${ApiEndpoints.imageProvider}${post.images[0]}',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      height: 300,
                      width: double.infinity,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey.shade200),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _buildMediaGrid(post.images),
              ),
        ],
      ),
    );
  }

  Widget _buildMediaGrid(List<String> images) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: images.length > 4 ? 4 : images.length,
      itemBuilder: (context, index) {
        final imageUrl = images[index];

        final randomHeight = 100 + (index % 4) * 40;
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              barrierColor: Colors.black,
              builder: (_) {
                return Dialog(
                  backgroundColor: Colors.black,
                  insetPadding: EdgeInsets.zero,
                  child: ImagePreviewDialog(
                    images: images,
                    initialIndex: index,
                  ),
                );
              },
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: '${ApiEndpoints.imageProvider}$imageUrl',
                  fit: BoxFit.cover,
                  height: randomHeight.toDouble(),
                  width: double.infinity,
                  placeholder: (context, url) => Container(
                    height: randomHeight.toDouble(),
                    color: Colors.grey.shade200,
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: randomHeight.toDouble(),
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image),
                  ),
                ),
                if (index == 3)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withAlpha(150),
                      alignment: Alignment.center,
                      child: Text(
                        '+${images.length - 4}',
                        style: context.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPostActions(Post post) {
    ValueNotifier<bool> isLikedNotifier = ValueNotifier(
      post.reacts.any((element) => element.user.id == user.id),
    );
    ValueNotifier<int> reactsCount = ValueNotifier(post.reactsCount);
    final react = post.reacts.where((element) => element.user.id == user.id);

    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: reactsCount,
          builder: (context, reactCount, child) {
            return ValueListenableBuilder(
              valueListenable: isLikedNotifier,
              builder: (context, liked, child) {
                return LikeButton(
                  onTap: (isLiked) async {
                    if (isLiked) {
                      if (react.isNotEmpty) {
                        homeCubit.unReactPost(react.first.id);
                      }

                      isLikedNotifier.value = !liked;
                      reactsCount.value -= 1;
                      return !liked;
                    }
                    isLikedNotifier.value = !liked;
                    reactsCount.value += 1;
                    homeCubit.reactPost(post.id);
                    return !liked;
                  },
                  size: 35.sp,
                  isLiked: liked,
                  likeCount: reactCount,
                  countDecoration: (_, count) => Text(
                    _formatCount(count ?? 0),
                    style: context.textTheme.bodyLarge,
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(width: 8),
        if (!_isMyPost(post))
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // homeCubit.rePost(post.id);
                  context.push(
                    UpdatePostScreen(
                      images: post.images,
                      postId: post.id,
                      isRePost: true,
                    ),
                  );
                },
                icon: Icon(Icons.repeat, size: 35.sp),
              ),
              Text(
                _formatCount(post.reactsCount),
                style: context.textTheme.bodyLarge,
              ),
            ],
          ),
      ],
    );
  }

  void _showPostOptions(Offset position, Post post) {
    CustomPopupMenu.show(
      context: context,
      position: position,
      items: [
        if (_isMyPost(post))
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text('Edit Post', style: context.textTheme.headlineSmall),
            onTap: () {
              CustomPopupMenu.hide();
              context.push(
                UpdatePostScreen(images: post.images, postId: post.id),
              );
            },
          ),
        if (_isMyPost(post))
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: Text(
              'Delete post',
              style: context.textTheme.headlineSmall?.copyWith(
                color: Colors.red,
              ),
            ),
            onTap: () {
              showCustomDialog(
                context,
                title: 'Deleting post',
                content: 'Your are sure to delete this post',
                confirmText: 'Delete',
                cancelText: 'cancel',
                cancelTextColor: AppPalette.primaryColor,
                onConfirm: () {
                  context.pop();
                  homeCubit.deletePosts(post.id);
                },
                onCancel: () {
                  context.pop();
                },
              );
              CustomPopupMenu.hide();
            },
          ),
        if (!_isMyPost(post))
          Builder(
            builder: (context) {
              final savedPosts = (postsBox.get(user.id) as List<String>?) ?? [];
              return ListTile(
                leading: Icon(
                  Icons.bookmark,
                  color: savedPosts.contains(post.id)
                      ? Colors.red
                      : Colors.grey,
                ),
                title: Text(
                  savedPosts.contains(post.id) ? 'Unsave post' : 'Save Post',
                  style: context.textTheme.headlineSmall,
                ),
                onTap: () {
                  final userId = user.id;
                  final postId = post.id;

                  // Get the user's saved posts, or empty list if none
                  final savedPosts =
                      (postsBox.get(userId) as List<String>?) ?? [];

                  // Check if the post is saved
                  final isSaved = savedPosts.contains(postId);

                  if (!isSaved) {
                    savedPosts.add(postId);
                  } else {
                    savedPosts.remove(postId);
                  }

                  // Save the updated list back under the user ID key
                  postsBox.put(userId, savedPosts);
                  CustomPopupMenu.hide();
                },
              );
            },
          ),
        // if (!_isMyPost(post))
        // ListTile(
        //   leading: const Icon(Icons.report_gmailerrorred_outlined, color: Colors.red),
        //   title: Text('Report Post', style: context.textTheme.headlineSmall?.copyWith(color: Colors.red)),
        //   onTap: () => CustomPopupMenu.hide(),
        // ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  bool _isMyPost(Post post) => user.id == post.user.id;
}

class ImagePreviewDialog extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ImagePreviewDialog({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<ImagePreviewDialog> createState() => _ImagePreviewDialogState();
}

class _ImagePreviewDialogState extends State<ImagePreviewDialog> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: widget.images.length,
          itemBuilder: (context, index) {
            return InteractiveViewer(
              child: Center(
                child: CachedNetworkImage(
                  imageUrl:
                      '${ApiEndpoints.imageProvider}${widget.images[index]}',
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
        Positioned(
          top: 40,
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SmoothPageIndicator(
            controller: _controller,
            count: widget.images.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppPalette.primaryColor,
              dotHeight: 8.w,
              dotWidth: 8.w,
            ),
          ),
        ),
      ],
    );
  }
}

bool didRePost(Post post) {
  if (post.repostedFrom == null) {
    return false;
  } else {
    return true;
  }
}
