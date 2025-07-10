import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:save_heaven/core/error/failure.dart';
import 'package:save_heaven/core/services/api_services.dart';
import 'package:save_heaven/core/utils/api_endpoints.dart';
import 'package:save_heaven/core/utils/constants.dart';

abstract interface class DonationRemoteDataSource {
  Future<Either<Failure, void>> donate({
    required bool isMony,
    DonateMony? monyModel,
    DonationItems? itemModel,
  });
}

class DonationRemoteDataSourceImpl implements DonationRemoteDataSource {
  final ApiService apiService;

  DonationRemoteDataSourceImpl({required this.apiService});

  @override
  Future<Either<Failure, void>> donate({
    required bool isMony,
    DonateMony? monyModel,
    DonationItems? itemModel,
  }) async {
    try {
      await apiService.post(
        endpoint: isMony
            ? ApiEndpoints.donationsMony
            : ApiEndpoints.donationItems,
        hasToken: true,
        data: isMony ? monyModel?.toJson() : itemModel?.toJson(),
      );
      return const Right(null);
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

class DonateMony {
  final String orphanageId;
  final int amount;
  final String paymentMethod;
  final String cardHolderName;
  final String cardNumber;
  final String cvc;
  final String expiryDate;

  DonateMony({
    required this.orphanageId,
    required this.amount,
    required this.paymentMethod,
    required this.cardHolderName,
    required this.cardNumber,
    required this.cvc,
    required this.expiryDate,
  });

  factory DonateMony.fromJson(Map<String, dynamic> json) {
    return DonateMony(
      orphanageId: json['orphanageId'],
      amount: json['amount'],
      paymentMethod: json['paymentMethod'],
      cardHolderName: json['cardHolderName'],
      cardNumber: json['cardNumber'],
      cvc: json['cvc'],
      expiryDate: json['expiryDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orphanageId': orphanageId,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'cvc': cvc,
      'expiryDate': expiryDate,
    };
  }
}

class DonationItems {
  final String? userId;
  final String? orphanageId;

  final String? itemType;

  // Clothes
  final String? clothingCondition;
  final int? piecesCount;

  // Food
  final String? foodType;
  final String? foodQuantity;

  final bool? isReadyForPickup;
  final String? deliveryMethod;
  final String? deliveryDate; // Or DateTime if you want
  final String? deliveryTime;
  final String? deliveryLocation;

  final String? receiptNumber;
  final String? status;
  final DateTime? createdAt;

  DonationItems({
    this.userId,
    this.orphanageId,
    this.itemType,
    this.clothingCondition,
    this.piecesCount,
    this.foodType,
    this.foodQuantity,
    this.isReadyForPickup,
    this.deliveryMethod,
    this.deliveryDate,
    this.deliveryTime,
    this.deliveryLocation,
    this.receiptNumber,
    this.status,
    this.createdAt,
  });

  factory DonationItems.fromJson(Map<String, dynamic> json) {
    return DonationItems(
      userId: json['userId'] as String?,
      orphanageId: json['orphanageId'] as String?,
      itemType: json['itemType'] as String?,
      clothingCondition: json['clothingCondition'] as String?,
      piecesCount: json['piecesCount'] as int?,
      foodType: json['foodType'] as String?,
      foodQuantity: json['foodQuantity'] as String?,
      isReadyForPickup: json['isReadyForPickup'] as bool?,
      deliveryMethod: json['deliveryMethod'] as String?,
      deliveryDate: json['deliveryDate'] as String?,
      deliveryTime: json['deliveryTime'] as String?,
      deliveryLocation: json['deliveryLocation'] as String?,
      receiptNumber: json['receiptNumber'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'orphanageId': orphanageId,
      'itemType': itemType,
      'clothingCondition': clothingCondition,
      'piecesCount': piecesCount,
      'foodType': foodType,
      'foodQuantity': foodQuantity,
      'isReadyForPickup': isReadyForPickup,
      'deliveryMethod': deliveryMethod,
      'deliveryDate': deliveryDate,
      'deliveryTime': deliveryTime,
      'deliveryLocation': deliveryLocation,
      'receiptNumber': receiptNumber,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  DonationItems copyWith({
    String? userId,
    String? orphanageId,
    String? itemType,
    String? clothingCondition,
    int? piecesCount,
    String? foodType,
    String? foodQuantity,
    bool? isReadyForPickup,
    String? deliveryMethod,
    String? deliveryDate,
    String? deliveryTime,
    String? deliveryLocation,
    String? receiptNumber,
    String? status,
    DateTime? createdAt,
  }) {
    return DonationItems(
      userId: userId ?? this.userId,
      orphanageId: orphanageId ?? this.orphanageId,
      itemType: itemType ?? this.itemType,
      clothingCondition: clothingCondition ?? this.clothingCondition,
      piecesCount: piecesCount ?? this.piecesCount,
      foodType: foodType ?? this.foodType,
      foodQuantity: foodQuantity ?? this.foodQuantity,
      isReadyForPickup: isReadyForPickup ?? this.isReadyForPickup,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryLocation: deliveryLocation ?? this.deliveryLocation,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
