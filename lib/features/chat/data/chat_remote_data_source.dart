import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_heaven/core/error/failure.dart';
import 'package:save_heaven/core/services/web_socket.dart';

abstract interface class ChatRemoteDataSource {
  // Stream<Either<Failure, List<String>>> getChats();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl();
}
