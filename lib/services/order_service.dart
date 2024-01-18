import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/models/orderDetails.dart';

class OrderDetailService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  addDocument(String customerId, double totalAmount, DateTime orderDate,
      String address, DateTime deliveryDate, bool deliveryStatus) async {
    OrderDetails orderDetails = OrderDetails(
        customerId: customerId,
        totalAmount: totalAmount,
        orderDate: orderDate,
        address: address,
        deliveryDate: deliveryDate,
        deliveryStatus: deliveryStatus);

    await db.collection("Order").add(orderDetails.toMap());
  }
}
