// Order Model
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String productId;
  final String productName;
  final double productPrice;

  // Buyer Details
  final String buyerName;
  final String buyerEmail;
  final String buyerPhone;
  final String buyerAddress;

  // Farmer Details
  final String farmerName;
  final String farmerEmail;
  final String farmerPhone;
  final String farmerAddress;

  final String buyerId;
  final String farmerId;
  final DateTime? transactionDate;

  OrderModel({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.buyerName,
    required this.buyerEmail,
    required this.buyerPhone,
    required this.buyerAddress,
    required this.farmerName,
    required this.farmerEmail,
    required this.farmerPhone,
    required this.farmerAddress,
    required this.buyerId,
    required this.farmerId,
    this.transactionDate,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return OrderModel(
      productId: data['productID'] ?? '',
      productName: data['productName'] ?? '',
      productPrice: (data['productPrice'] ?? 0.0).toDouble(),
      buyerName: data['buyerName'] ?? '',
      buyerEmail: data['buyerEmail'] ?? '',
      buyerPhone: data['buyerPhone'] ?? '',
      buyerAddress: data['buyerAddress'] ?? '',
      farmerName: data['farmerName'] ?? '',
      farmerEmail: data['farmerEmail'] ?? '',
      farmerPhone: data['farmerPhone'] ?? '',
      farmerAddress: data['farmerAddress'] ?? '',
      buyerId: data['buyerId'] ?? '',
      farmerId: data['farmerId'] ?? '',
      transactionDate: (data['transactionDate'] as Timestamp?)?.toDate(),
    );
  }
}
