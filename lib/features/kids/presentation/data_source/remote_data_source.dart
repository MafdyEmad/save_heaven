import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_heaven/core/error/failure.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/constants.dart';
import 'package:save_heaven/features/kids/data/models/kid_model.dart';
import 'package:save_heaven/features/kids/data/models/orphanages_response.dart';
import 'package:save_heaven/features/profile/data/models/child_model.dart';

abstract interface class OrphanageRemoteDataSource {
  Future<Either<Failure, OrphanagesResponse>> getPosts();
  Future<Either<Failure, List<ChildModel>>> getAllKids(String id);
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

  @override
  Future<Either<Failure, List<ChildModel>>> getAllKids(String id) async {
    try {
      final result = await apiService.get(
        endpoint: ApiEndpoints.getAllKids(id),
        hasToken: true,
      );
      final json = result.data['data'];
      final kids = json.map<ChildModel>((e) => ChildModel.fromJson(e)).toList();
      return Right(kids);
    } on DioException catch (e) {
      return Left(
        Failure(
          message: e.response?.data?['message'] ?? Constants.serverErrorMessage,
        ),
      );
    } catch (e) {
      print(e);
      return Left(Failure(message: Constants.serverErrorMessage));
    }
  }
}
