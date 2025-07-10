import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_heaven/core/error/failure.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/constants.dart';
import 'package:save_heaven/features/orphanage_dontaion/data/models/adoption_requests.dart';
import 'package:save_heaven/features/orphanage_dontaion/data/models/donation_model.dart';

abstract interface class OrphanageDonationRemoteDataSource {
  Future<Either<Failure, List<AdoptionRequestsModel>>> getAdoptionRequests();
  Future<Either<Failure, void>> respondToRequest(
    String requestId,
    String response,
  );
  Future<Either<Failure, List<DonationModel>>> getDonations();
}

class OrphanageDonationRemoteDataSourceImpl
    implements OrphanageDonationRemoteDataSource {
  final ApiService apiService;

  OrphanageDonationRemoteDataSourceImpl({required this.apiService});
  @override
  Future<Either<Failure, List<AdoptionRequestsModel>>>
  getAdoptionRequests() async {
    try {
      final response = await apiService.get(
        endpoint: ApiEndpoints.adoptionRequests,
        hasToken: true,
      );
      final json = response.data['data'] as List<dynamic>;
      return Right(json.map((e) => AdoptionRequestsModel.fromJson(e)).toList());
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
  Future<Either<Failure, void>> respondToRequest(
    String requestId,
    String response,
  ) async {
    try {
      await apiService.put(
        endpoint: '${ApiEndpoints.adoptionRequests}/$requestId',
        hasToken: true,
        data: {'status': response},
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

  @override
  Future<Either<Failure, List<DonationModel>>> getDonations() async {
    try {
      final result = await Future.wait([
        apiService.get(endpoint: ApiEndpoints.donationItems, hasToken: true),
        apiService.get(endpoint: ApiEndpoints.donationsMony, hasToken: true),
      ]);

      final itemDonations = (result[0].data['data'] as List)
          .map((e) => DonationModel.fromJson(e))
          .toList();

      final moneyDonations = (result[1].data['data'] as List)
          .map((e) => DonationModel.fromJson(e))
          .toList();

      final allDonations = [...itemDonations, ...moneyDonations];
      return Right(allDonations);
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
