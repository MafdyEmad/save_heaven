import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_heaven/core/error/failure.dart';
import 'package:save_heaven/core/hive/adapters/user_adapter/user_hive.dart';
import 'package:save_heaven/core/hive/hive_boxes/hive_boxes.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/constants.dart';
import 'package:save_heaven/features/auth/data/models/user_model.dart';
import 'package:save_heaven/features/orphanage_dontaion/data/models/adoption_requests.dart';
import 'package:save_heaven/features/profile/data/models/child_model.dart';
import 'package:save_heaven/features/profile/data/models/porfile_model.dart';

abstract interface class ProfileRemoteDataSource {
  Future<Either<Failure, UserDataResponse>> getUser();
  Future<Either<Failure, UserModel>> updateUser({
    required ProfileUpdateparams params,
  });
  Future<Either<Failure, void>> addNewOrphan({required OrphanParams params});
  Future<Either<Failure, List<ChildModel>>> getOurKids(String id);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiService apiService;

  ProfileRemoteDataSourceImpl({required this.apiService});
  @override
  Future<Either<Failure, UserDataResponse>> getUser() async {
    try {
      final result = await apiService.get(
        endpoint: ApiEndpoints.getUser,
        hasToken: true,
      );
      return Right(UserDataResponse.fromJson(result.data['data']));
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
  Future<Either<Failure, UserModel>> updateUser({
    required ProfileUpdateparams params,
  }) async {
    try {
      late final Response result;
      if (params.image == null) {
        result = await apiService.put(
          endpoint: ApiEndpoints.updateUser,
          data: params.toJson(),
          hasToken: true,
        );
      } else {
        result = await apiService.updateFormData(
          files: [params.image!],
          endpoint: ApiEndpoints.updateUser,
          fileFieldName: 'image',
          fields: params.toJson(),
        );
      }
      final user = UserModel.fromJson(
        result.data['data']['user'],
        result.data['data']['orphanage'],
      );
      HiveBoxes.userBox.putAt(0, UserHive.fromModel(user));
      return Right(user);
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
  Future<Either<Failure, void>> addNewOrphan({
    required OrphanParams params,
  }) async {
    try {
      await apiService.sendFormData(
        files: [params.image],
        endpoint: ApiEndpoints.children,
        fileFieldName: 'image',
        fields: params.toJson(),
      );
      return const Right(null);
    } on DioException catch (e) {
      print(e.response?.data);
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
  Future<Either<Failure, List<ChildModel>>> getOurKids(String id) async {
    try {
      final result = await apiService.get(
        endpoint: ApiEndpoints.getChildren(id),
        hasToken: true,
      );
      final json = result.data['data'] as List<dynamic>;

      return Right(json.map((e) => ChildModel.fromJson(e)).toList());
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

class ProfileUpdateparams {
  final String? name;
  final File? image;
  final WorkSchedule? workSchedule;
  final String? email;
  final String? address;

  ProfileUpdateparams({
    this.name,
    this.image,
    this.workSchedule,
    this.email,
    this.address,
  });
  Map<String, dynamic> toJson() => {
    'name': name,
    'workSchedule': workSchedule != null ? workSchedule?.toJson() : {},
    // 'email': email,
    if (address != null) 'address': address,
  };
}

class OrphanParams {
  final String name;
  final String birthdate;
  final File image;
  final String gender;
  final String religion;
  final String hairColor;
  final String hairStyle;
  final String skinTone;
  final String eyeColor;
  final String personality;

  OrphanParams({
    required this.name,
    required this.birthdate,
    required this.image,
    required this.gender,
    required this.religion,
    required this.hairColor,
    required this.hairStyle,
    required this.skinTone,
    required this.eyeColor,
    required this.personality,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'birthdate': birthdate,
      'gender': gender,
      'religion': religion,
      'hairColor': hairColor,
      'hairStyle': hairStyle,
      'skinTone': skinTone,
      'eyeColor': eyeColor,
      'personality': personality,
    };
  }
}
