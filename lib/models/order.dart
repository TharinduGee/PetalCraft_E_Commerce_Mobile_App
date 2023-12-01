import 'dart:ffi';

class Order {
  Order(
      {required this.id,
      required this.customerId,
      required this.productId,
      required this.totalAmount,
      required this.orderDate,
      required this.address,
      required this.deliveryDate,
      required this.deliveryStatus});

  final String id;
  final String customerId;
  final String productId;
  final Double totalAmount;
  final DateTime orderDate;
  final String address;
  final DateTime deliveryDate;
  final bool deliveryStatus;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "customerId": customerId,
      'productId': productId,
      "totalAmount": totalAmount,
      "orderDate": orderDate,
      "address": address,
      'deliveryDate': deliveryDate,
      "deliveryStatus": deliveryStatus,
    };
  }
}
