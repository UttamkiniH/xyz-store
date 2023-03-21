class OrderModel {
  String orderId;
  String userLocation;
  String warehouseLocation;
  num orderPrice;
  String payMode;
  String orderDate;
  OrderModel({
    required this.orderId,
    required this.userLocation,
    required this.warehouseLocation,
    required this.orderPrice,
    required this.payMode,
    required this.orderDate,
  });
}
