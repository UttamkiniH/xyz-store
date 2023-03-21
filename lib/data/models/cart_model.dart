class CartModel {
  String productId;
  List<dynamic> productImage;
  String productName;
  num productPrice;
  int quantity;

  CartModel(
      {required this.productId,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.quantity});

  CartModel.fromJson(Map<String, dynamic> json)
      : productId = json["productId"],
        productImage = json["productImage"],
        productName = json["productName"],
        productPrice = json["productPrice"],
        quantity = json["quantity"];

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productImage': productImage,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
    };
  }
}
