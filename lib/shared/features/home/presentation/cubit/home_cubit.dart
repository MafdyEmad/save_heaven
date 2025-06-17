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
    final result = await _homeRemoteDataSource.makePost(images: images, content: content);
    result.fold(
      (fail) => emit(HomeMakePostsFail(message: fail.message)),
      (_) => emit(HomeMakePostsSuccess()),
    );
  }
}
