import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:save_heaven/core/error/failure.dart';
import 'package:save_heaven/core/hive/adapters/user_adapter/user_hive.dart';
import 'package:save_heaven/core/hive/hive_boxes/hive_boxes.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/constants.dart';
import 'package:save_heaven/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<Either<Failure, UserModel>> signUpDonor({
    required String name,
    required String email,
    required String address,
    required String password,
    required String phone,
    required String birthdate,
    required String gender,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});
  @override
  Future<Either<Failure, UserModel>> signUpDonor({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
    required String birthdate,
    required String gender,
  }) async {
    try {
      final response = await apiService.post(
        endpoint: ApiEndpoints.signUp,
        hasToken: false,
        data: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'passwordConfirm': password,
          'address': address,
          'phone': phone,
          'birthdate': birthdate,
          'gender': gender,
          'role': 'Donor',
        }),
      );
      final jsonMap = response.data;
      final userJson = jsonMap['data']['user'];
      final orphanageJson = jsonMap['data']['orphanage'];

      final user = UserModel.fromJson(userJson, orphanageJson);
      final token = jsonMap['token'];

      final userId = JwtDecoder.decode(token)['userId'];
      await HiveBoxes.userBox.put(userId, UserHive.fromModel(user));
      if (HiveBoxes.secureBox.isNotEmpty) {
        await HiveBoxes.secureBox.putAt(0, token);
      } else {
        await HiveBoxes.secureBox.add(token);
      }
      return Right(user);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final List<String> messages = (e.response?.data['errors'] as List)
            .map((e) => e['msg'].toString())
            .toList();
        return Left(Failure(message: messages.join('.\n')));
      }
      return Left(Failure(message: Constants.serverErrorMessage));
    } catch (e) {
      print(e);
      return Left(Failure(message: Constants.serverErrorMessage));
    }
  }
}
