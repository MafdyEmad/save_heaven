import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' as user;
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/screens/update_post_screen.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_colors.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/utils/show_dialog.dart';
import 'package:save_heaven/core/widgets/custom_pop_menu.dart';
import 'package:save_heaven/features/profile/data/models/porfile_model.dart';
import 'package:save_heaven/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:save_heaven/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:save_heaven/shared/features/home/data/models/post_response.dart';
import 'package:save_heaven/shared/features/home/presentation/cubit/home_cubit.dart';
import 'package:save_heaven/shared/features/home/presentation/screens/home_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final bloc = getIt<ProfileCubit>();
  @override
  void initState() {
    bloc.getUser();
    super.initState();
  }

  final states = List.unmodifiable([
    GetProfileUserLoading,
    GetProfileUserFail,
    GetProfileUserSuccess,
  ]);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocBuilder<ProfileCubit, ProfileState>(
              buildWhen: (previous, current) =>
                  states.contains(current.runtimeType),
              builder: (context, state) {
                if (state is GetProfileUserLoading || state is ProfileInitial) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Column(
                      children: [
                        SizedBox(
                          height: context.height * 0.35,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                height: context.height * 0.25,
                                decoration: BoxDecoration(
                                  color: AppPalette.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(height: 20, width: 100, color: Colors.white),
                      ],
                    ),
                  );
                }
                if (state is GetProfileUserFail) {
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
                        onPressed: () => bloc.getUser(),
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
                final user = (state as GetProfileUserSuccess).user;
                return DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context,
                        ),
                        sliver: SliverAppBar(
                          expandedHeight: context.height * .6,
                          pinned: true,
                          floating: true,
                          flexibleSpace: FlexibleSpaceBar(
                            background: _buildHeader(user),
                          ),
                          bottom: TabBar(
                            labelStyle: Theme.of(
                              context,
                            ).textTheme.headlineMedium,
                            dividerColor: Colors.transparent,
                            indicatorColor: const Color(0xfffcd06b),
                            tabs: const [
                              Tab(text: 'Posts'),
                              Tab(text: 'About us'),
                            ],
                          ),
                        ),
                      ),
                    ],
                    body: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.horizontalPagePadding,
                          ),
                          child: _buildPosts(
                            user.posts,
                          ), // This ListView works alone
                        ),
                        Builder(
                          builder: (context) {
                            return CustomScrollView(
                              key: PageStorageKey('AboutUs'),
                              slivers: [
                                SliverOverlapInjector(
                                  handle:
                                      NestedScrollView.sliverOverlapAbsorberHandleFor(
                                        context,
                                      ),
                                ),
                                SliverPadding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        AppDimensions.horizontalPagePadding,
                                  ),
                                  sliver: SliverList(
                                    delegate: SliverChildListDelegate([
                                      _buildAbout(user.about),
                                    ]),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildAbout(About about) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(Icons.date_range_rounded),
            Text("Working days", style: context.textTheme.headlineLarge),
          ],
        ),
        Wrap(
          spacing: 10,
          children: [
            ...about.workDays.map(
              (e) => Chip(
                label: Text(
                  e,
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: AppPalette.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Icon(Icons.access_time, color: AppPalette.primaryColor),
            SizedBox(width: 8),
            Text(
              "Working Hours",
              style: context.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'From:',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                about.workHours.isEmpty ? '' : about.workHours.first,
                style: context.textTheme.headlineMedium?.copyWith(
                  color: AppPalette.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'To:',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                about.workHours.isEmpty ? '' : about.workHours.last,
                style: context.textTheme.headlineMedium?.copyWith(
                  color: AppPalette.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(UserDataResponse user) {
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.35,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: context.height * 0.25,
                decoration: BoxDecoration(color: AppPalette.primaryColor),
              ),

              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 88,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 85,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: CachedNetworkImageProvider(
                        '${ApiEndpoints.imageProvider}${user.user.image}',
                      ),
                      // child: const Icon(
                      //   Icons.person,
                      //   size: 60,
                      //   color: Colors.grey,
                      // ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(user.user.name, style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 10),
        Row(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on, color: AppPalette.primaryColor),
            Text(
              user.user.address,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Icon(Icons.calendar_month, color: AppPalette.primaryColor),
            Text(
              'joined ${DateFormat('MMMM yyyy').format(user.about.establishedDate)}',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.horizontalPagePadding,
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  onPressed: () {
                    context.push(
                      EditProfileScreen(userId: user.user.id, user: user),
                    );
                  },
                  child: Text(
                    'Edit Profile',
                    style: context.textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppDimensions.horizontalPagePadding),
              if (user.user.role != 'Donor')
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Our Kids',
                      style: context.textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        SizedBox(height: 20),
        // Expanded(child: TabBarView(children: screens)),
      ],
    );
  }

  Widget _buildPosts(List<Post> posts) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 20.h, top: 60.h),
      itemCount: posts.length,
      separatorBuilder: (context, index) => Divider(height: 30),
      itemBuilder: (context, index) {
        final post = posts[index];
        return _buildPost(post);
      },
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
                      getIt<HomeCubit>().unReactPost(react.first.id);
                      isLikedNotifier.value = !liked;
                      reactsCount.value -= 1;
                      return !liked;
                    }
                    isLikedNotifier.value = !liked;
                    reactsCount.value += 1;
                    getIt<HomeCubit>().reactPost(post.id);
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
        // const SizedBox(width: 8),
        // if (!_isMyPost(post))
        //   Row(
        //     children: [
        //       IconButton(
        //         onPressed: () {
        //           context.push(
        //             UpdatePostScreen(
        //               images: post.images,
        //               postId: post.id,
        //               isRePost: true,
        //             ),
        //           );
        //         },
        //         icon: Icon(Icons.repeat, size: 35.sp),
        //       ),
        //       Text(
        //         _formatCount(post.reactsCount),
        //         style: context.textTheme.bodyLarge,
        //       ),
        //     ],
        //   ),
      ],
    );
  }

  void _showPostOptions(Offset position, Post post) {
    CustomPopupMenu.show(
      context: context,
      position: position,
      items: [
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

        ListTile(
          leading: const Icon(Icons.delete, color: Colors.red),
          title: Text(
            'Delete post',
            style: context.textTheme.headlineSmall?.copyWith(color: Colors.red),
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
                getIt<HomeCubit>().deletePosts(post.id);
              },
              onCancel: () {
                context.pop();
              },
            );
            CustomPopupMenu.hide();
          },
        ),
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
}
