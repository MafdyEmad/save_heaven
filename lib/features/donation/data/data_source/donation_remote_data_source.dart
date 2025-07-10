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
  final String? orphanageId;
  final String? itemType;
  final String? clothingCondition;
  final int? piecesCount;
  final bool? isReadyForPickup;
  final String? deliveryMethod;
  final String? deliveryDate; // You can change this to DateTime if needed
  final String? deliveryTime;
  final String? deliveryLocation;

  DonationItems({
    this.orphanageId,
    this.itemType,
    this.clothingCondition,
    this.piecesCount,
    this.isReadyForPickup,
    this.deliveryMethod,
    this.deliveryDate,
    this.deliveryTime,
    this.deliveryLocation,
  });

  factory DonationItems.fromJson(Map<String, dynamic> json) {
    return DonationItems(
      orphanageId: json['orphanageId'],
      itemType: json['itemType'],
      clothingCondition: json['clothingCondition'],
      piecesCount: json['piecesCount'],
      isReadyForPickup: json['isReadyForPickup'],
      deliveryMethod: json['deliveryMethod'],
      deliveryDate: json['deliveryDate'],
      deliveryTime: json['deliveryTime'],
      deliveryLocation: json['deliveryLocation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orphanageId': orphanageId,
      'itemType': itemType,
      'clothingCondition': clothingCondition,
      'piecesCount': piecesCount,
      'isReadyForPickup': isReadyForPickup,
      'deliveryMethod': deliveryMethod,
      'deliveryDate': deliveryDate,
      'deliveryTime': deliveryTime,
      'deliveryLocation': deliveryLocation,
    };
  }

  /// ✅ copyWith to create a new instance with some fields changed
  DonationItems copyWith({
    String? orphanageId,
    String? itemType,
    String? clothingCondition,
    int? piecesCount,
    bool? isReadyForPickup,
    String? deliveryMethod,
    String? deliveryDate,
    String? deliveryTime,
    String? deliveryLocation,
  }) {
    return DonationItems(
      orphanageId: orphanageId ?? this.orphanageId,
      itemType: itemType ?? this.itemType,
      clothingCondition: clothingCondition ?? this.clothingCondition,
      piecesCount: piecesCount ?? this.piecesCount,
      isReadyForPickup: isReadyForPickup ?? this.isReadyForPickup,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryLocation: deliveryLocation ?? this.deliveryLocation,
    );
  }
}
