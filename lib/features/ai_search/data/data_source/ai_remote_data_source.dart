import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_heaven/core/error/failure.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/constants.dart';
import 'package:save_heaven/features/profile/data/models/child_model.dart';

abstract interface class AiRemoteDataSource {
  Future<Either<Failure, List<ChildModel>>> aiSearch(String query);
}

class AiRemoteDataSourceImpl implements AiRemoteDataSource {
  final ApiService apiService;

  AiRemoteDataSourceImpl({required this.apiService});
  @override
  Future<Either<Failure, List<ChildModel>>> aiSearch(String query) async {
    try {
      final result = await apiService.post(
        endpoint: ApiEndpoints.aiSearch,
        hasToken: true,
        data: {'query': query},
      );
      final kids = result.data['kids'] as List<dynamic>;
      return Right(kids.map((e) => ChildModel.fromJson(e)).toList());
    } on DioException catch (_) {
      return Left(Failure(message: Constants.serverErrorMessage));
    } catch (e) {
      print(e);
      return Left(Failure(message: Constants.serverErrorMessage));
    }
  }
}
