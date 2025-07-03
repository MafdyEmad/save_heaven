import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  Future<Either<Failure, UserModel>> signUpOrphanage({
    required OrphanageSignUpParams params,
  });
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
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
          'notificationToken': await FirebaseMessaging.instance.getToken(),
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
      return Left(Failure(message: Constants.serverErrorMessage));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpOrphanage({
    required OrphanageSignUpParams params,
  }) async {
    try {
      final response = await apiService.post(
        endpoint: ApiEndpoints.signUp,
        hasToken: false,
        data: {
          ...params.toJson(),
          'notificationToken': await FirebaseMessaging.instance.getToken(),
        },
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
      return Left(Failure(message: Constants.serverErrorMessage));
    }
  }

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        endpoint: ApiEndpoints.login,
        hasToken: false,
        data: {
          'email': email,
          'password': password,
          'notificationToken': await FirebaseMessaging.instance.getToken(),
        },
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
      return Left(Failure(message: e.response?.data['message']));
      // return Left(Failure(message: Constants.serverErrorMessage));
    } catch (e) {
      return Left(Failure(message: Constants.serverErrorMessage));
    }
  }
}

class OrphanageSignUpParams {
  final String? name;
  final String? password;
  final String? passwordConfirm;
  final String? adminName;
  final String? email;
  final String? phone;
  final String? address;
  final int? currentChildren;
  final int? totalCapacity;
  final int? staffCount;
  final List<String>? workDays;
  final List<String>? workHours;
  final String? establishedDate;
  final String? birthdate;
  final String? image;
  final String? gender;

  OrphanageSignUpParams({
    this.name,
    this.password,
    this.passwordConfirm,
    this.adminName,
    this.email,
    this.phone,
    this.address,
    this.currentChildren,
    this.totalCapacity,
    this.staffCount,
    this.workDays,
    this.workHours,
    this.establishedDate,
    this.birthdate,
    this.image,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': password,
      'passwordConfirm': passwordConfirm,
      'adminName': adminName,
      'email': email,
      'phone': phone,
      'address': address,
      'currentChildren': currentChildren,
      'totalCapacity': totalCapacity,
      'staffCount': staffCount,
      'workDays': workDays,
      'workHours': workHours,
      'establishedDate': establishedDate,
      'birthdate': establishedDate,
      'image': image,
      // 'gender': gender,
      'role': 'Orphanage',
    };
  }

  OrphanageSignUpParams copyWith({
    String? name,
    String? password,
    String? passwordConfirm,
    String? adminName,
    String? email,
    String? phone,
    String? address,
    int? currentChildren,
    int? totalCapacity,
    int? staffCount,
    List<String>? workDays,
    List<String>? workHours,
    String? establishedDate,
    String? birthdate,
    String? image,
    String? gender,
  }) {
    return OrphanageSignUpParams(
      name: name ?? this.name,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      adminName: adminName ?? this.adminName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      currentChildren: currentChildren ?? this.currentChildren,
      totalCapacity: totalCapacity ?? this.totalCapacity,
      staffCount: staffCount ?? this.staffCount,
      workDays: workDays ?? this.workDays,
      workHours: workHours ?? this.workHours,
      establishedDate: establishedDate ?? this.establishedDate,
      birthdate: birthdate ?? this.birthdate,
      image: image ?? this.image,
      gender: gender ?? this.gender,
    );
  }
}
