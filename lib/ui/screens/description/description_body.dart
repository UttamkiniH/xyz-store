import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xyz_store/data/data.dart';
import 'package:xyz_store/providers/providers.dart';

import '../../../common/app_colors.dart';
import '../../widgets/widgets.dart';

class DescriptionBody extends StatelessWidget {
  DescriptionBody({Key? key, required this.index, required this.isSelectedSize})
      : super(key: key);
  final int index;
  late bool isSelectedSize;

  @override
  Widget build(BuildContext context) {
    List<ProductModel> productData =
        context.watch<ProductProvider>().productData;
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
        child: Scrollbar(
          child: ListView(
            // physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productData[index].name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: GlobalColors().buttonAccent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        child: Text(
                          'Rs. ${productData[index].price.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.deblur,
                          color: GlobalColors().primaryRed,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          tr("details"),
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      productData[index].description,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          color: GlobalColors().primaryRed,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Select Size",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0;
                            i < productData[index].sizes.length;
                            i++)
                          RadioButtons(
                              productData: productData,
                              index: index,
                              radioIndex: i,
                              isSelectedSize: isSelectedSize),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
