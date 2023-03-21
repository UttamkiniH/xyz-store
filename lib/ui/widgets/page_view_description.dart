import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';

class PageViewWidgetDescPageApp extends StatelessWidget {
  const PageViewWidgetDescPageApp({
    Key? key,
    required this.productData,
    required this.imageIndex,
    required this.index,
  }) : super(key: key);

  final List<ProductModel> productData;
  final int index;
  final int imageIndex;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      productData[index].images[imageIndex],
      fit: BoxFit.fitWidth,
    );
  }
}
