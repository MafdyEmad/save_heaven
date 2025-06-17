import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:like_button/like_button.dart';
import 'package:save_heaven/core/config/app_palette.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/app_dimensions.dart';
import 'package:save_heaven/core/utils/dependence.dart';
import 'package:save_heaven/core/utils/extensions.dart';
import 'package:save_heaven/core/widgets/custom_pop_menu.dart';
import 'package:save_heaven/core/widgets/custom_refresh.dart';
import 'package:save_heaven/core/widgets/make_post_widget.dart';
import 'package:save_heaven/shared/features/home/data/models/post_response.dart';
import 'package:save_heaven/shared/features/home/presentation/cubit/home_cubit.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit homeCubit;
  @override
  void initState() {
    homeCubit = getIt<HomeCubit>()..getPosts();
    super.initState();
  }

  final homeGetPostsStates = List.unmodifiable([HomeGetPostsSuccess, HomeGetPostsLoading, HomeGetPostsFail]);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeCubit,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPagePadding),
          child: Builder(
            builder: (context) {
              return BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) => homeGetPostsStates.contains(current.runtimeType),
                builder: (context, state) {
                  if (state is HomeGetPostsLoading) {
                    return ListView.separated(
                      itemBuilder: (context, index) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(width: double.infinity, height: 250, color: Colors.white),
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 20),
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
                    },
                    child: ListView.separated(
                      padding: EdgeInsets.only(bottom: 20.h),
                      itemCount: posts.posts.length + 1,
                      separatorBuilder: (context, index) => index == 0 ? SizedBox.shrink() : Divider(),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return MakePostWidget(
                            image:
                                'https://t4.ftcdn.net/jpg/01/95/94/75/240_F_195947506_f7Gt71TOQvwHbQq6gprW6QSJLlxY00oV.jpg',
                            name: 'name',
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
              // imageUrl: post.user.imageUrl
              imageUrl: '',
              width: 50.w,
              height: 50.w,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => const Icon(Icons.person),
            ),
          ),
          trailing: GestureDetector(
            onTapDown: (details) => _showPostOptions(details.globalPosition),
            child: const Icon(Icons.more_horiz, color: Colors.grey),
          ),
          title: Text(post.user.name, style: context.textTheme.headlineMedium),
          subtitle: Text('Orphanage Address', style: context.textTheme.headlineSmall),
        ),
        _buildPostContent(post),
        _buildPostActions(post),
      ],
    );
  }

  Widget _buildPostContent(Post post) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPagePadding, vertical: 10),
      color: const Color(0xFFF6F7F8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpandableText(
            post.content,
            expandText: 'Read More',
            collapseText: 'Read Less',
            animation: true,
            maxLines: 8,
            style: context.textTheme.headlineMedium,
            linkColor: AppPalette.primaryColor,
          ),
          if (post.images.isNotEmpty)
            Padding(padding: const EdgeInsets.only(top: 10), child: _buildMediaGrid(post.images)),
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
      itemCount: images.length,
      itemBuilder: (context, index) {
        final imageUrl = images[index];

        // Vary the height for visual variety
        final randomHeight = 100 + (index % 4) * 40;

        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            height: randomHeight.toDouble(),
            width: double.infinity,
            placeholder: (context, url) =>
                Container(height: randomHeight.toDouble(), color: Colors.grey.shade200),
            errorWidget: (context, url, error) => Container(
              height: randomHeight.toDouble(),
              color: Colors.grey.shade300,
              child: const Icon(Icons.broken_image),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPostActions(Post post) {
    return Row(
      children: [
        LikeButton(
          size: 35.sp,
          // isLiked: post.isLiked,
          // likeCount: post.likes,
          isLiked: true,
          likeCount: 585,
          countDecoration: (_, count) => Text(_formatCount(count ?? 0), style: context.textTheme.bodyLarge),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.repeat, size: 35.sp),
        ),
        // Text(_formatCount(post.shares), style: context.textTheme.bodyLarge),
        Text(_formatCount(5848), style: context.textTheme.bodyLarge),
      ],
    );
  }

  void _showPostOptions(Offset position) {
    CustomPopupMenu.show(
      context: context,
      position: position,
      items: [
        ListTile(
          leading: const Icon(Icons.edit),
          title: Text('Edit Post', style: context.textTheme.headlineSmall),
          onTap: () => CustomPopupMenu.hide(),
        ),
        ListTile(
          leading: const Icon(Icons.bookmark),
          title: Text('Save Post', style: context.textTheme.headlineSmall),
          onTap: () => CustomPopupMenu.hide(),
        ),
        ListTile(
          leading: const Icon(Icons.report_gmailerrorred_outlined, color: Colors.red),
          title: Text('Report Post', style: context.textTheme.headlineSmall?.copyWith(color: Colors.red)),
          onTap: () => CustomPopupMenu.hide(),
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
