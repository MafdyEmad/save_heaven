import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_heaven/core/caching/caching_keys.dart';
import 'package:save_heaven/core/caching/caching_manager.dart';
import 'package:save_heaven/core/error/failure.dart';
import 'package:save_heaven/shared/features/home/data/models/post_response.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/constants.dart';

abstract interface class HomeRemoteDataSource {
  Future<Either<Failure, PostsResponse>> getPosts({required bool refresh});
  Future<Either<Failure, void>> makePost({required List<File> images, required String content});
  Future<Either<Failure, void>> deletePost(String postId);
  Future<Either<Failure, void>> updatePost(String postId);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService apiService;
  final CacheManager cacheManager;

  HomeRemoteDataSourceImpl({required this.apiService, required this.cacheManager});
  @override
  Future<Either<Failure, PostsResponse>> getPosts({required bool refresh}) async {
    const cacheKey = CachingKeys.posts;

    try {
      if (refresh) {
        cacheManager.removeKey(cacheKey);
      }

      final cachedData = cacheManager.getData(cacheKey);
      if (cachedData != null) {
        return Right(PostsResponse.fromJson(cachedData));
      }

      final response = await apiService.get(endpoint: ApiEndpoints.posts, hasToken: false);

      if (response.statusCode == 200 && response.data != null) {
        cacheManager.setData(cacheKey, response.data);
        return Right(PostsResponse.fromJson(response.data));
      } else {
        return Left(Failure(message: response.data?['message'] ?? Constants.serverErrorMessage));
      }
    } catch (e) {
      return Left(Failure(message: Constants.serverErrorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> makePost({required List<File> images, required String content}) async {
    try {
      await apiService.sendFormData(
        fileFieldName: 'images',
        fields: {'content': content},
        files: images,
        endpoint: ApiEndpoints.posts,
        hasToken: true,
      );

      return Right(null);
    } on TimeoutException {
      return Left(Failure(message: 'Time out, Try again'));
    } on DioException catch (e) {
      print(e);
      return Left(Failure(message: e.response?.data?['message'] ?? Constants.serverErrorMessage));
    } catch (e) {
      return Left(Failure(message: Constants.serverErrorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(postId) async {
    try {
      await apiService.delete(endpoint: '${ApiEndpoints.posts}/$postId', hasToken: true);
      return Right(null);
    } catch (e) {
      return Left(Failure(message: Constants.serverErrorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> updatePost(String postId) async {
    try {
      await apiService.put(endpoint: '${ApiEndpoints.posts}/$postId', hasToken: true);
      return Right(null);
    } catch (e) {
      return Left(Failure(message: Constants.serverErrorMessage));
    }
  }
}
