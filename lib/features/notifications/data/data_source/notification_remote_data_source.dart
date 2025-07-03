import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_heaven/core/error/failure.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/constants.dart';
import 'package:save_heaven/features/notifications/data/data_source/models/notification_model.dart';

abstract interface class NotificationRemoteDataSource {
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
  Future<Either<Failure, int>> getUnreadNotificationsCount();
  Future<Either<Failure, void>> makeNotationRead();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiService apiService;

  NotificationRemoteDataSourceImpl({required this.apiService});
  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      final response = await apiService.get(
        endpoint: ApiEndpoints.notifications,
        hasToken: true,
      );
      final json = response.data['data'] as List<dynamic>;
      return Right(json.map((e) => NotificationModel.fromJson(e)).toList());
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
  Future<Either<Failure, int>> getUnreadNotificationsCount() async {
    try {
      final response = await apiService.get(
        endpoint: ApiEndpoints.unReadNotificationsCount,
        hasToken: true,
      );
      final count = response.data['count'] as dynamic;
      return Right(count);
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
  Future<Either<Failure, void>> makeNotationRead() async {
    try {
      await apiService.patch(
        endpoint: ApiEndpoints.readNotification,
        hasToken: true,
      );

      return Right(null);
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
