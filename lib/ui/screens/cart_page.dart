import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:xyz_store/common/app_colors.dart';
import 'package:xyz_store/data/models/cart_model.dart';
import 'package:xyz_store/providers/providers.dart';
import 'package:xyz_store/ui/widgets/widgets.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await context.read<ProductProvider>().getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    //*instead of listen=true.use.context.watch
    List<CartModel> cartData = context.watch<ProductProvider>().cartData;
    final provider = Provider.of<ThemeProvider>(context);
    num totalPrice = context.read<ProductProvider>().totalPrice;

    return Scaffold(
        appBar: CustomAppBar(
          textString: "Cart",
        ),
        body: cartData.isNotEmpty
            ? Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),

                        // height: MediaQuery.of(context).size.height * 0.035,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(tr("remove_all_products")),
                            IconButton(
                              onPressed: (() {
                                showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        title: const Text(
                                            "Do you want to Remove all items from Cart? "),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context, 'Cancel');
                                              },
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                context
                                                    .read<ProductProvider>()
                                                    .deleteCartProducts();
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Yes"))
                                        ],
                                      )),
                                );
                              }),
                              icon: const Icon(
                                Icons.delete_rounded,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                              itemCount: cartData.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    minVerticalPadding: 10,
                                    contentPadding: const EdgeInsets.all(10),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                          image: NetworkImage(
                                              cartData[index].productImage[1])),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        cartData[index].productName,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '₹ ${cartData[index].productPrice.toString()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: GlobalColors().primaryRed),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            context
                                                .read<ProductProvider>()
                                                .incrementCart(
                                                    cartData[index].quantity,
                                                    cartData[index].productId,
                                                    index);
                                          },
                                          icon: Icon(
                                            Icons.add_circle_rounded,
                                            color: GlobalColors().buttonAccent,
                                          ),
                                        ),
                                        Text('${cartData[index].quantity}'),
                                        IconButton(
                                          onPressed: () {
                                            context
                                                .read<ProductProvider>()
                                                .decrementCart(
                                                    cartData[index].quantity,
                                                    cartData[index].productId,
                                                    index);
                                          },
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            color: GlobalColors().buttonAccent,
                                          ),
                                        )
                                      ],
                                    ));
                              })),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Price
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: GlobalColors().primaryRed),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                        ),
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr("total_price"),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "₹ $totalPrice",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: GlobalColors().primaryRed),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            padding: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(00)),
                            textStyle: Theme.of(context).textTheme.headline6,
                          ),
                          onPressed: () {
                            context.pushNamed('location');
                          },
                          child: Text(tr("proceed_checkout")))
                    ],
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(80.0),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: provider.darkTheme
                            ? LottieBuilder.asset(
                                'assets/lottie/shopping_cart_white.json')
                            : LottieBuilder.asset(
                                'assets/lottie/shopping_cart.json',
                                width: double.infinity,
                              )),
                  ),
                  const Text(
                    "Please add your products in cart",
                  )
                ],
              ));
  }
}
