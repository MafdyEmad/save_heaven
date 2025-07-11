import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/shared/features/home/data/data_source/home_remote_data_source.dart';
import 'package:save_heaven/shared/features/home/data/models/post_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRemoteDataSource _homeRemoteDataSource;
  HomeCubit({required HomeRemoteDataSource homeRemoteDataSource})
    : _homeRemoteDataSource = homeRemoteDataSource,

      super(HomeInitial());

  void getPosts({bool refresh = false}) async {
    emit(HomeGetPostsLoading());
    final result = await _homeRemoteDataSource.getPosts(refresh: refresh);
    result.fold(
      (fail) => emit(HomeGetPostsFail(message: fail.message)),
      (posts) => emit(HomeGetPostsSuccess(posts: posts)),
    );
  }

  void makePosts({required String content, required List<File> images}) async {
    emit(HomeMakePostsLoading());
    final result = await _homeRemoteDataSource.makePost(
      images: images,
      content: content,
    );
    result.fold(
      (fail) => emit(HomeMakePostsFail(message: fail.message)),
      (_) => emit(HomeMakePostsSuccess()),
    );
  }

  void deletePosts(String postId) async {
    emit(HomeDeletePostsLoading());
    final result = await _homeRemoteDataSource.deletePost(postId);
    result.fold(
      (fail) => emit(HomeDeletePostsFail(message: fail.message)),
      (_) => emit(HomeDeletePostsSuccess()),
    );
  }

  void updatePosts(String postId, String content) async {
    emit(HomeUpdatePostsLoading());
    final result = await _homeRemoteDataSource.updatePost(postId, content);
    result.fold(
      (fail) => emit(HomeUpdatePostsFail(message: fail.message)),
      (_) => emit(HomeUpdatePostsSuccess()),
    );
  }

  void rePost(String postId, String content) async {
    emit(HomeRePostLoading());
    final result = await _homeRemoteDataSource.rePost(postId, content);
    result.fold(
      (fail) => emit(HomeRePostFail()),
      (_) => emit(HomeRePostSuccess()),
    );
  }

  void getSavedPosts(List<String> ids) async {
    emit(HomeGetSavedPostsLoading());
    final result = await _homeRemoteDataSource.getSavedPosts(ids);
    result.fold(
      (fail) => emit(HomeGetSavedPostsFail(message: fail.message)),
      (posts) => emit(HomeGetSavedPostsSuccess(posts: posts)),
    );
  }

  void reactPost(String postId) async {
    await _homeRemoteDataSource.reactPost(postId);
  }

  void unReactPost(String postId) async {
    await _homeRemoteDataSource.unReactPost(postId);
  }
}
