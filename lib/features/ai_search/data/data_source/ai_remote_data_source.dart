import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_heaven/core/error/failure.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/constants.dart';
import 'package:http/http.dart' as http;

abstract interface class AiRemoteDataSource {
  Future<Either<Failure, void>> aiSearch(String query);
}

class AiRemoteDataSourceImpl implements AiRemoteDataSource {
  final ApiService apiService;

  AiRemoteDataSourceImpl({required this.apiService});
  @override
  Future<Either<Failure, void>> aiSearch(String query) async {
    try {
      print('asdsadasdas');
      return Right(null);
    } on DioException catch (e) {
      return Left(
        Failure(
          message: e.response?.data?['error'] ?? Constants.serverErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(message: Constants.serverErrorMessage));
    }
  }
}
