import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xyz_store/data/models/cart_model.dart';
import 'package:xyz_store/data/models/order_model.dart';
import 'package:xyz_store/data/models/product_model.dart';
import 'package:xyz_store/ui/widgets/show_snackbar.dart';

class ProductProvider extends ChangeNotifier {
  //*ProductList and CartList
  List<ProductModel> productData = [];
  List<CartModel> cartData = [];
  List cartDataId = [];
  num totalPrice = 0;
  List<OrderModel> orderList = [];

  //*.initialising firebase auth
  FirebaseAuth auth = FirebaseAuth.instance;
  late var currentUser = auth.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('user');

//*product functionality
  getProducts() {
    productData.clear();
    FirebaseFirestore.instance
        .collection('product')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> addingData = doc.data()! as Map<String, dynamic>;

        var temporaryData =
            ProductModel.fromJson(jsonDecode(jsonEncode(addingData)));
        productData.add(temporaryData);
      }

      notifyListeners();
    });
  }

//*Cart funtionality
  getCartProducts() async {
    cartData.clear();
    FirebaseFirestore.instance
        .collection('user')
        .doc(currentUser!.email)
        .collection('cart')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> addingData = doc.data()! as Map<String, dynamic>;
        var temporaryData =
            CartModel.fromJson(jsonDecode(jsonEncode(addingData)));
        cartData.add(temporaryData);
      }
      notifyListeners();
      getTotalPrice();
    });
  }

  updateCart(List<CartModel> data) {
    cartData = data;
    notifyListeners();
  }

  addToCart(int index, BuildContext context) {
    var cart = users
        .doc(currentUser!.email)
        .collection("cart")
        .doc(productData[index].id);

    cart.get().then((value) {
      if (value.exists) {
        var cartModel = CartModel.fromJson(value.data()!);
        cartModel.quantity += 1;

        cart
            .set(cartModel.toJson())
            .then((value) => showSnackBar("Updated Cart", context))
            .catchError(
                (error) => showSnackBar("Failed to addtoCart", context));
      } else {
        CartModel cartModel = CartModel(
            productId: productData[index].id,
            productImage: productData[index].images,
            productName: productData[index].name,
            productPrice: productData[index].price,
            quantity: 1);

        cart
            .set(cartModel.toJson())
            .then((value) => showSnackBar("Added to Cart", context))
            .catchError(
                (error) => showSnackBar("Failed to addtoCart", context));
      }
    });
  }

  incrementCart(int quantity, String id, int index) {
    quantity += 1;

    return users
        .doc(currentUser!.email)
        .collection("cart")
        .doc(id)
        .update({"quantity": quantity}).then(
      (value) {
        getCartProducts();
        updateCart(cartData);
      },
    );
  }

  decrementCart(int quantity, String id, int index) {
    if (quantity > 1) {
      quantity -= 1;
      return users
          .doc(currentUser!.email)
          .collection("cart")
          .doc(id)
          .update({"quantity": quantity}).then(
        (value) {
          getCartProducts();
          updateCart(cartData);
        },
      );
    }
  }

//*check cart products
  checkCart(int index) async {
    var cid = productData[index].id;
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('user')
        .doc(currentUser!.email)
        .collection('cart');
    try {
      var doc = await collectionRef.doc(cid).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  //*delete cart products
  Future<void> deleteCartProducts() async {
    try {
      var snapshots =
          await users.doc(currentUser!.email).collection('cart').get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
      totalPrice = 0;
      getCartProducts();
    } catch (e) {
      rethrow;
    }
  }

  //*calculate Total
  getTotalPrice() {
    num temp = 0.0;
    for (int i = 0; i < cartData.length; i++) {
      temp += cartData[i].quantity * cartData[i].productPrice;
    }
    totalPrice = temp;
    notifyListeners();
  }

//*favourite functionality
  addToFavourite(int index) {
    return users
        .doc(currentUser!.email)
        .collection('favourites')
        .doc(productData[index].name)
        .set({"id": productData[index].id}).then(
            (value) => print("Added to fav ${productData[index].name}"));
  }

  //*search products
  getProductDetails(String query) {
    var searchResult = FirebaseFirestore.instance
        .collection('product')
        .where("keywords", arrayContains: query)
        .get();
    print(searchResult);
  }

  @override
  notifyListeners();
}
