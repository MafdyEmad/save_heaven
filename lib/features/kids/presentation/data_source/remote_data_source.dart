import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_heaven/core/error/failure.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/constants.dart';
import 'package:save_heaven/features/kids/data/models/orphanages_response.dart';

abstract interface class OrphanageRemoteDataSource {
  Future<Either<Failure, OrphanagesResponse>> getPosts();
}

class OrphanageRemoteDataSourceImpl extends OrphanageRemoteDataSource {
  final ApiService apiService;

  OrphanageRemoteDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, OrphanagesResponse>> getPosts() async {
    try {
      final result = await apiService.get(
        endpoint: ApiEndpoints.getOrphanages,
        hasToken: true,
      );
      return Right(OrphanagesResponse.fromJson(result.data));
    } on DioException catch (e) {
      return Left(
        Failure(
          message: e.response?.data?['message'] ?? Constants.serverErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(message: Constants.serverErrorMessage));
    }
  }
}
