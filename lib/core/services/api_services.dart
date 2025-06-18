import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:save_heaven/core/hive/hive_boxes/hive_boxes.dart';
import 'package:save_heaven/main.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  final Dio _dio;

  factory ApiService() {
    return _instance;
  }

  static String get _userToken => HiveBoxes.secureBox.getAt(0);

  ApiService._internal() : _dio = Dio() {
    _dio.options = BaseOptions(
      baseUrl: '',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    );
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }

  Future<Response> get({
    bool hasToken = true,
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(
          headers: {
            ..._dio.options.headers,
            ...?headers,
            if (hasToken) 'Authorization': 'Bearer $_userToken',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post({
    bool hasToken = true,
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.post(
        endpoint,
        onSendProgress: (int sent, int total) {
          print((sent / total) * 100);
        },
        data: data,
        options: Options(
          headers: {
            ..._dio.options.headers,
            ...?headers,
            if (hasToken) 'Authorization': 'Bearer $_userToken',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future sendFormData({
    required List<File> files,
    required String endpoint,
    required String fileFieldName,
    required Map<String, dynamic> fields,
    bool hasToken = true,
  }) async {
    final dio = Dio();
    final formData = FormData();

    for (var file in files) {
      final fileName = file.path.split('/').last;
      final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      final mediaType = MediaType.parse(mimeType);

      formData.files.add(
        MapEntry(
          fileFieldName,
          await MultipartFile.fromFile(file.path, filename: fileName, contentType: mediaType),
        ),
      );
    }

    fields.forEach((key, value) {
      formData.fields.add(MapEntry(key, value.toString()));
    });

    final response = await dio.post(
      endpoint,
      options: Options(
        headers: {if (hasToken) 'Authorization': 'Bearer $_userToken', 'Content-Type': 'multipart/form-data'},
      ),
      data: formData,
      onSendProgress: (sent, total) {
        final percent = (sent / total * 100).toStringAsFixed(2);
        print('Upload progress: $percent%');
      },
    );

    return response;
  }

  Future<Response> asd({
    required String endpoint,
    required Map<String, dynamic> fields,
    required List<File> files,
    required String fileFieldName,
    bool hasToken = true,
  }) async {
    final formData = FormData();

    fields.forEach((key, value) {
      formData.fields.add(MapEntry(key, value.toString()));
    });

    for (File file in files) {
      final fileName = file.path.split('/').last;
      formData.files.add(MapEntry('images', await MultipartFile.fromFile(file.path, filename: fileName)));
    }

    return await post(endpoint: endpoint, data: formData, hasToken: hasToken);
  }

  Future<Response> put({
    bool hasToken = true,
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.put(
        endpoint,
        data: data,
        options: Options(
          headers: {
            ..._dio.options.headers,
            ...?headers,
            if (hasToken) 'Authorization': 'Bearer $_userToken',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patch({
    bool hasToken = true,
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.patch(
        endpoint,
        data: data,
        options: Options(
          headers: {
            ..._dio.options.headers,
            ...?headers,
            if (hasToken) 'Authorization': 'Bearer $_userToken',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete({
    bool hasToken = true,
    required String endpoint,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.delete(
        endpoint,
        options: Options(
          headers: {
            ..._dio.options.headers,
            ...?headers,
            if (hasToken) 'Authorization': 'Bearer $_userToken',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
