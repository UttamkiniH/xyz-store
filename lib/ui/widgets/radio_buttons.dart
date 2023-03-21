import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';

class RadioButtons extends StatefulWidget {
  RadioButtons(
      {Key? key,
      required this.productData,
      required this.index,
      required this.radioIndex,
      required this.isSelectedSize})
      : super(key: key);

  final List<ProductModel> productData;
  final int index;
  final int radioIndex;
  late bool isSelectedSize;

  @override
  State<RadioButtons> createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: widget.isSelectedSize ? Colors.redAccent : Colors.grey),
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            print(" ${widget.isSelectedSize} before");
            widget.isSelectedSize = !widget.isSelectedSize;
          });
        },
        icon: Text(
          widget.productData[widget.index].sizes[widget.radioIndex],
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
