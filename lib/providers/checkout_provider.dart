import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'package:xyz_store/data/models/order_model.dart';

import '../data/models/cart_model.dart';

var uuid = const Uuid();

class FetchLocationProvider extends ChangeNotifier {
  String? address;

//*fetch Location provider
  Future<Position> determinePostion() async {
    bool isService;
    LocationPermission locationPermission;

    isService = await Geolocator.isLocationServiceEnabled();
    if (!isService) {
      Future.error('Serives are disabled');
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location Permission is denied");
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    try {
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemark[0];

      address =
          "${place.street}\n ${place.subLocality}, ${place.subThoroughfare}\n ${place.subAdministrativeArea}, ${place.administrativeArea}\n ${place.postalCode}";

      notifyListeners();
      return position;
    } catch (e) {
      rethrow;
    }
  }
}

class FetchOrderProvider extends ChangeNotifier {
//*generateOrder
  OrderModel? oderData;

  generateOrder(List<CartModel> cartData, num totalPrice) {
    var id = uuid.v4().substring(1, 7);

    oderData = OrderModel(
        orderId: id,
        userLocation: "Uttams house",
        warehouseLocation:
            "2008, 100 Feet Rd, HAL 2nd Stage, Kodihalli, Bengaluru, Karnataka 560008",
        orderPrice: totalPrice,
        payMode: "UPI",
        orderDate: DateTime.now().toString());
  }
}
