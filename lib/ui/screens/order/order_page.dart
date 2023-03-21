import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xyz_store/providers/checkout_provider.dart';
import 'package:xyz_store/providers/products_provider.dart';
import 'package:xyz_store/ui/widgets/widgets.dart';

import '../../../data/models/cart_model.dart';
import '../../../data/models/order_model.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<CartModel> cartData = context.watch<ProductProvider>().cartData;
    num totalPrice = context.watch<ProductProvider>().totalPrice;
    context.read<FetchOrderProvider>().generateOrder(cartData, totalPrice);
    String? address = context.read<FetchLocationProvider>().address;
    OrderModel orderDatae = context.watch<FetchOrderProvider>().oderData!;

    return Scaffold(
      appBar: CustomAppBar(textString: "Order"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.done),
        label: const Text("Confrim Details"),
        onPressed: () {
          context.pushNamed('completed');
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Summary",
              style: Theme.of(context).textTheme.headline5,
            ),
            ExpansionTile(
                title: const Text('Item Details'),
                textColor: Colors.black,
                children: [
                  for (int i = 0; i < cartData.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(cartData[i].productImage[0])),
                        // cartData[i].productPrice.toString()
                        trailing: Text(
                            "${cartData[i].quantity} × ₹ ${cartData[i].productPrice.toString()}"),
                        // cartData[i].quantity.toString()
                        subtitle: Text(
                            "Quantity : ${cartData[i].quantity.toString()}"),
                        title: Text(cartData[i].productName.toString()),
                      ),
                    )
                ]),
            Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                color: Colors.grey[100],
                height: MediaQuery.of(context).size.height * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OrderPageTextTitleWidget(titleString: "Order id"),
                    OrderPageTextSubtitleWidget(subtitle: orderDatae.orderId),
                    const SizedBox(
                      height: 10,
                    ),
                    const OrderPageTextTitleWidget(titleString: "Payment Mode"),
                    OrderPageTextSubtitleWidget(subtitle: orderDatae.payMode),
                    const SizedBox(
                      height: 10,
                    ),
                    const OrderPageTextTitleWidget(titleString: "Deliver To"),
                    OrderPageTextSubtitleWidget(subtitle: address.toString()),
                    const SizedBox(
                      height: 10,
                    ),
                    const OrderPageTextTitleWidget(
                        titleString: "Order Placed on"),
                    OrderPageTextSubtitleWidget(subtitle: orderDatae.orderDate)
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class OrderPageTextSubtitleWidget extends StatelessWidget {
  final String subtitle;
  const OrderPageTextSubtitleWidget({Key? key, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(subtitle, style: Theme.of(context).textTheme.titleMedium);
  }
}

class OrderPageTextTitleWidget extends StatelessWidget {
  final String titleString;
  const OrderPageTextTitleWidget({Key? key, required this.titleString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titleString,
      style:
          Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
    );
  }
}
