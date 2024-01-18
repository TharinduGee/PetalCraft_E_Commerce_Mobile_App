import 'package:namer_app/models/cartItem.dart';
import 'package:namer_app/models/product.dart';

class Cart {
  Cart({
    required this.customerId,
    required Set<CartItem> cartItemList,
  });

  final String customerId;
  final cartItemList = <CartItem>{};

  Map<String, dynamic> toMap() {
    return {
      "customerId": customerId,
      "productList": cartItemList,
    };
  }
}
