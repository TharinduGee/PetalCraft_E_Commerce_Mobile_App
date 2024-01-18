class OrderDetails {
  OrderDetails(
      {required this.customerId,
      required this.totalAmount,
      required this.orderDate,
      required this.address,
      required this.deliveryDate,
      required this.deliveryStatus});

  final String customerId;
  final double totalAmount;
  final DateTime orderDate;
  final String address;
  final DateTime deliveryDate;
  final bool deliveryStatus;

  Map<String, dynamic> toMap() {
    return {
      "customerId": customerId,
      "totalAmount": totalAmount,
      "orderDate": orderDate,
      "address": address,
      'deliveryDate': deliveryDate,
      "deliveryStatus": deliveryStatus,
    };
  }
}
