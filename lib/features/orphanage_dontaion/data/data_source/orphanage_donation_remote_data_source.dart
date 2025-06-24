import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_heaven/core/error/failure.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/constants.dart';
import 'package:save_heaven/features/orphanage_dontaion/data/models/adoption_requests.dart';

abstract interface class OrphanageDonationRemoteDataSource {
  Future<Either<Failure, List<AdoptionRequestsModel>>> getAdoptionRequests();
}

class OrphanageDonationRemoteDataSourceImpl implements OrphanageDonationRemoteDataSource {
  final ApiService apiService;

  OrphanageDonationRemoteDataSourceImpl({required this.apiService});
  @override
  Future<Either<Failure, List<AdoptionRequestsModel>>> getAdoptionRequests() async {
    try {
      final response = await apiService.get(endpoint: ApiEndpoints.adoptionRequests, hasToken: true);
      final json = response.data['data'] as List<dynamic>;
      return Right(json.map((e) => AdoptionRequestsModel.fromJson(e)).toList());
    } on DioException catch (e) {
      return Left(Failure(message: e.response?.data?['message'] ?? Constants.serverErrorMessage));
    } catch (e) {
      return Left(Failure(message: Constants.serverErrorMessage));
    }
  }
}
