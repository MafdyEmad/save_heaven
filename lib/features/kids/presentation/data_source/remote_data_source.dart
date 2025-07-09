import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_heaven/core/error/failure.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/constants.dart';
import 'package:save_heaven/features/kids/data/models/orphanages_response.dart';
import 'package:save_heaven/features/profile/data/models/child_model.dart';

abstract interface class OrphanageRemoteDataSource {
  Future<Either<Failure, OrphanagesResponse>> getorphanage();
  Future<Either<Failure, List<ChildModel>>> getAllKids(String id);
  Future<Either<Failure, void>> adopt(AdoptionRequest request);
}

class OrphanageRemoteDataSourceImpl extends OrphanageRemoteDataSource {
  final ApiService apiService;

  OrphanageRemoteDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, OrphanagesResponse>> getorphanage() async {
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

  @override
  Future<Either<Failure, void>> adopt(AdoptionRequest request) async {
    try {
      await apiService.post(
        endpoint: ApiEndpoints.adopt,
        hasToken: true,
        data: request.toJson(),
      );

      return Right(null);
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

class AdoptionRequest {
  final String childId;
  final String phone;
  final String orphanageId;
  final String maritalStatus;
  final String occupation;
  final int monthlyIncome;
  final String religion;
  final String location;
  final String reason;

  AdoptionRequest({
    required this.childId,
    required this.orphanageId,
    required this.phone,
    required this.maritalStatus,
    required this.occupation,
    required this.monthlyIncome,
    required this.religion,
    required this.location,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'childId': childId,
      'phone': phone,
      'maritalStatus': maritalStatus,
      'occupation': occupation,
      'monthlyIncome': monthlyIncome,
      'orphanage': orphanageId,
      'religion': religion,
      'location': location,
      'reason': reason,
    };
  }
}
