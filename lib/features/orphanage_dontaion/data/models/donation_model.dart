class DonationModel {
  final String id;
  final String donorName;
  final String donorImage;
  final String orphanageName;
  final String receiptNumber;
  final DateTime createdAt;

  // Item donation fields
  final String? itemType;
  final String? foodQuantity;
  final int? piecesCount;
  final String? deliveryMethod;
  final DateTime? deliveryDate;
  final String? clothingCondition;
  final bool? isReadyForPickup;
  final String? status;

  // Money donation fields
  final double? amount;
  final String? paymentMethod;
  final String? donationType;

  DonationModel({
    required this.id,
    required this.donorName,
    required this.donorImage,
    required this.orphanageName,
    required this.receiptNumber,
    required this.createdAt,
    this.itemType,
    this.foodQuantity,
    this.piecesCount,
    this.deliveryMethod,
    this.deliveryDate,
    this.status,
    this.clothingCondition,
    this.isReadyForPickup,
    this.amount,
    this.paymentMethod,
    this.donationType,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'] ?? '',
      donorName: json['donorName'] ?? '',
      donorImage: json['donorImage'] ?? '',
      orphanageName: json['orphanageName'] ?? '',
      receiptNumber: json['receiptNumber'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      itemType: json['itemType'],
      deliveryMethod: json['deliveryMethod'],
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.tryParse(json['deliveryDate'])
          : null,
      status: json['status'],
      amount: json['amount'] != null
          ? (json['amount'] as num).toDouble()
          : null,
      paymentMethod: json['paymentMethod'],
      donationType: json['donationType'],
      foodQuantity: json['foodQuantity'] ?? '',
      piecesCount: json['piecesCount'] ?? 0,
      clothingCondition: json['clothingCondition'] ?? '',
      isReadyForPickup: json['isReadyForPickup'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'donorName': donorName,
      'donorImage': donorImage,
      'orphanageName': orphanageName,
      'receiptNumber': receiptNumber,
      'createdAt': createdAt.toIso8601String(),
      'itemType': itemType,
      'deliveryMethod': deliveryMethod,
      'deliveryDate': deliveryDate?.toIso8601String(),
      'status': status,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'donationType': donationType,
    };
  }
}
