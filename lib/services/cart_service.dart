import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/models/cart.dart';
import 'package:namer_app/models/cartItem.dart';
import 'package:namer_app/models/notification.dart';
import 'package:namer_app/models/product.dart';
import 'dart:async';

class CartService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> deleteItem(String productId, String customerId) async {
    QuerySnapshot querySnapshot = await db
        .collection('Cart')
        .where('customerId', isEqualTo: customerId)
        .limit(1)
        .get();

    String id = querySnapshot.docs.first.id;
    CollectionReference productCollection =
        db.collection("Cart").doc(id).collection("ProductList");

    QuerySnapshot existingProductQuerySnapshot = await productCollection
        .where('productId', isEqualTo: productId)
        .limit(1)
        .get();

    if (existingProductQuerySnapshot.docs.isNotEmpty) {
      QuerySnapshot existingProductQuerySnapshot = await productCollection
          .where('productId', isEqualTo: productId)
          .limit(1)
          .get();

      DocumentReference<Map<String, dynamic>> deleteItem = db
          .collection("Cart")
          .doc(id)
          .collection("ProductList")
          .doc(existingProductQuerySnapshot.docs.first.id);

      deleteItem.delete().then((_) {
        print('Document deleted successfully');
      }).catchError((error) {
        print('Error deleting document: $error');
      });
    }
  }

  Future<void> decrementQuantity(
      String productId, String customerId, int c) async {
    QuerySnapshot querySnapshot = await db
        .collection('Cart')
        .where('customerId', isEqualTo: customerId)
        .limit(1)
        .get();

    String id = querySnapshot.docs.first.id;
    CollectionReference productCollection =
        db.collection("Cart").doc(id).collection("ProductList");

    QuerySnapshot existingProductQuerySnapshot = await productCollection
        .where('productId', isEqualTo: productId)
        .limit(1)
        .get();

    if (existingProductQuerySnapshot.docs.isNotEmpty) {
      QuerySnapshot existingProductQuerySnapshot = await productCollection
          .where('productId', isEqualTo: productId)
          .limit(1)
          .get();

      DocumentReference<Map<String, dynamic>> updatableItem = db
          .collection("Cart")
          .doc(id)
          .collection("ProductList")
          .doc(existingProductQuerySnapshot.docs.first.id);

      int quantity;

      updatableItem
          .get()
          .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        if (documentSnapshot.exists) {
          // Document exists, access the field values
          Map<String, dynamic> data = documentSnapshot.data()!;

          // Access specific field values
          quantity = data['quantity'] ??
              0; // Initialize to 0 if 'quantity' is not present

          // Perform operations with the field values
          print('Initial Quantity: $quantity');

          // Increment the quantity
          int updatedQuantity = quantity + c;

          // Proceed with the update
          updatableItem.update({
            'quantity': updatedQuantity,
          }).then((_) {
            print('Field updated successfully');
          }).catchError((error) {
            print('Error updating field: $error');
          });
        } else {
          print('Document does not exist.');
        }
      }).catchError((error) {
        print('Error getting document: $error');
      });
    }
  }

  Future<void> addItem(String customerId, Product product, int quantity) async {
    Map<String, dynamic> cartItemMap = CartItem(
            productId: product.productId,
            productImage: product.productImage,
            name: product.name,
            price: product.price,
            description: product.description,
            category: product.category,
            quantity: quantity)
        .toMap();
    QuerySnapshot querySnapshot = await db
        .collection('Cart')
        .where('customerId', isEqualTo: customerId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // If the cart exists

      String id = querySnapshot.docs.first.id;
      CollectionReference productCollection =
          db.collection("Cart").doc(id).collection("ProductList");

      QuerySnapshot existingProductQuerySnapshot = await productCollection
          .where('productId', isEqualTo: product.productId)
          .limit(1)
          .get();

      if (existingProductQuerySnapshot.docs.isNotEmpty) {
        QuerySnapshot existingProductQuerySnapshot = await productCollection
            .where('productId', isEqualTo: product.productId)
            .limit(1)
            .get();

        DocumentReference<Map<String, dynamic>> updatableItem = db
            .collection("Cart")
            .doc(id)
            .collection("ProductList")
            .doc(existingProductQuerySnapshot.docs.first.id);

        int quantity;

        updatableItem
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
          if (documentSnapshot.exists) {
            // Document exists, access the field values
            Map<String, dynamic> data = documentSnapshot.data()!;

            // Access specific field values
            quantity = data['quantity'] ??
                0; // Initialize to 0 if 'quantity' is not present

            // Perform operations with the field values
            print('Initial Quantity: $quantity');

            // Increment the quantity
            int updatedQuantity = quantity + 1;

            // Proceed with the update
            updatableItem.update({
              'quantity': updatedQuantity,
            }).then((_) {
              print('Field updated successfully');
            }).catchError((error) {
              print('Error updating field: $error');
            });
          } else {
            print('Document does not exist.');
          }
        }).catchError((error) {
          print('Error getting document: $error');
        });

        print("Exists");
      } else {
        db
            .collection("Cart")
            .doc(id)
            .collection("ProductList")
            .add(cartItemMap)
            .then((DocumentReference subDoc) {
          print('Subcollection DocumentSnapshot added with ID: ${subDoc.id}');
        }).catchError((subError) {
          print('Error adding subcollection document: $subError');
        });
      }
    } else {
      // If the cart doesn't exist, create a new one add first product
      db
          .collection("Cart")
          .add({"customerId": customerId}).then((DocumentReference doc) {
        String cartDocumentId = doc.id;

        db
            .collection("Cart")
            .doc(cartDocumentId)
            .collection("ProductList")
            .add(cartItemMap)
            .then((DocumentReference subDoc) {
          print('Subcollection DocumentSnapshot added with ID: ${subDoc.id}');
        }).catchError((subError) {
          print('Error adding subcollection document: $subError');
        });
      });
    }
  }

  Future<Set<CartItem>> showCart(String customerId) async {
    Set<CartItem> productList = <CartItem>{};
    QuerySnapshot querySnapshot = await db
        .collection('Cart')
        .where('customerId', isEqualTo: customerId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      // If the cart doesn't exist, return an empty set
      return {};
    } else {
      String id = querySnapshot.docs.first.id;
      CollectionReference productCollection =
          db.collection("Cart").doc(id).collection("ProductList");

      QuerySnapshot existingProductQuerySnapshot =
          await productCollection.get();

      existingProductQuerySnapshot.docs.forEach((doc) {
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            doc as DocumentSnapshot<Map<String, dynamic>>;
        productList.add(CartItem.fromFirestore(documentSnapshot));
      });

      return productList;
    }
  }

  Stream<Set<CartItem>> showCartAsStream(String customerId) {
    StreamController<Set<CartItem>> _controller =
        StreamController<Set<CartItem>>();

    db
        .collection('Cart')
        .where('customerId', isEqualTo: customerId)
        .limit(1)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) async {
      Set<CartItem> productList = <CartItem>{};

      if (querySnapshot.docs.isEmpty) {
        // If the cart doesn't exist, emit an empty set
        _controller.add({});
      } else {
        String id = querySnapshot.docs.first.id;
        CollectionReference productCollection =
            db.collection("Cart").doc(id).collection("ProductList");

        productCollection.snapshots().listen((QuerySnapshot productSnapshot) {
          productList.clear(); // Clear the set before updating with new data

          productSnapshot.docs.forEach((doc) {
            DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
                doc as DocumentSnapshot<Map<String, dynamic>>;
            productList.add(CartItem.fromFirestore(documentSnapshot));
          });

          _controller.add(productList); // Emit the updated set
        });
      }
    });

    return _controller.stream;
  }
}
