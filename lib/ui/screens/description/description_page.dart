import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:xyz_store/ui/screens/screens.dart';

import '../../../data/models/product_model.dart';
import '../../../providers/products_provider.dart';

import 'description_header.dart';

class DescriptionPage extends StatefulWidget {
  DescriptionPage({super.key, required this.index});

  int index;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  bool? isThere;
  @override
  void initState() {
    checkCart();
    super.initState();
  }

  checkCart() async {
    bool tempBool;
    tempBool = await context.read<ProductProvider>().checkCart(widget.index);
    setState(() {
      isThere = tempBool;
    });
  }

  updateButton() {
    isThere ?? false
        ? context.goNamed('home', params: {'index': 2.toString()})
        : context.read<ProductProvider>().addToCart(widget.index, context);
  }

  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    List<ProductModel> productData =
        context.watch<ProductProvider>().productData;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          updateButton();
          setState(() {
            isThere = true;
          });
        },
        label:
            isThere ?? false ? Text(tr("go_to_cart")) : Text(tr("add_to_cart")),
        icon: const Icon(Icons.shopping_cart_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          ListView(
            // scrollDirection: Axis.horizontal,

            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            children: [
              DescriptionHeader(
                  pageController: _pageController,
                  productData: productData,
                  index: widget.index),
              DescriptionBody(index: widget.index, isSelectedSize: true),
            ],
          ),
        ],
      ),
    );
  }
}




// Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: ((context) => BottomNavBar(
//                   index: 2,
//                 ))))