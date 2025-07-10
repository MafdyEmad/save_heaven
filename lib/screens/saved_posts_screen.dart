import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/hive/adapters/user_adapter/user_hive.dart';
import 'package:save_heaven/core/hive/hive_boxes/hive_boxes.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/shared/features/home/data/models/post_response.dart';
import 'package:save_heaven/shared/features/home/presentation/cubit/home_cubit.dart';
import 'package:save_heaven/shared/features/home/presentation/screens/home_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class SavedPostsScreen extends StatefulWidget {
  const SavedPostsScreen({super.key});

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  late final UserHive user;
  final String token = HiveBoxes.secureBox.getAt(0);
  late final List savedPosts;
  final postsBox = HiveBoxes.postsBox;
  final bloc = getIt<HomeCubit>();
  @override
  void initState() {
    final userId = JwtDecoder.decode(token)['userId'];
    user = HiveBoxes.userBox.get(userId);
    savedPosts = (postsBox.get(userId) as List<String>?) ?? [];
    if (savedPosts.isNotEmpty) {
      bloc.getSavedPosts(savedPosts as List<String>);
    }
    super.initState();
  }

  final states = List.unmodifiable([
    HomeGetSavedPostsSuccess,
    HomeGetSavedPostsLoading,
    HomeGetSavedPostsFail,
  ]);
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Saved Posts', style: context.textTheme.titleLarge),
        ),
        body: savedPosts.isEmpty
            ? Center(
                child: Text(
                  'No saved posts',
                  style: context.textTheme.headlineLarge,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.horizontalPagePadding,
                ),
                child: BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (previous, current) =>
                      states.contains(current.runtimeType),
                  builder: (context, state) {
                    if (state is HomeGetSavedPostsLoading) {
                      return ListView.separated(
                        itemCount: 10,
                        separatorBuilder: (context, index) =>
                            Divider(height: 10),
                        itemBuilder: (context, index) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: double.infinity,
                            height: 250,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                    if (state is HomeGetSavedPostsFail) {
                      return Center(
                        child: Text(
                          'Failed to get saved posts',
                          style: context.textTheme.headlineLarge,
                        ),
                      );
                    }
                    if (state is HomeGetSavedPostsSuccess) {
                      return ListView.builder(
                        itemCount: savedPosts.length,
                        itemBuilder: (context, index) =>
                            _buildPost(state.posts[index]),
                      );
                    }
                    return SizedBox.shrink();
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
          trailing: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  final userId = user.id;
                  final postId = post.id;
                  final savedPosts =
                      (postsBox.get(userId) as List<String>?) ?? [];

                  savedPosts.remove(postId);
                  setState(() {});
                },
                icon: Icon(Icons.bookmark, color: Colors.red),
              );
            },
          ),
          title: Text(post.user.name, style: context.textTheme.headlineMedium),
          subtitle: Text(
            DateTime.now().difference(post.createdAt).inDays == 0
                ? timeago.format(post.createdAt)
                : DateFormat('yyyy-MM-dd').format(post.createdAt),
            style: context.textTheme.headlineSmall,
          ),
        ),

        _buildPostContent(post),
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
}
