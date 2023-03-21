import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../data/models/product_model.dart';
import '../../widgets/widgets.dart';

class DescriptionHeader extends StatelessWidget {
  const DescriptionHeader({
    Key? key,
    required PageController pageController,
    required this.productData,
    required this.index,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;
  final List<ProductModel> productData;
  final int index;


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: PageView(
            controller: _pageController,
            children: [
              for (int i = 0; i < productData[index].images.length; i++)
                PageViewWidgetDescPageApp(
                    productData: productData, imageIndex: i, index: index)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.035,
              MediaQuery.of(context).size.height * 0.07,
              MediaQuery.of(context).size.height * 0.01,
              0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackButton(
                color: Colors.red,
              ),
              IconButton(
                  onPressed: () {
                    print("Pressed");
                  },
                  icon: Icon(
                    Icons.favorite_border_rounded,
                    size: 30,
                    color: GlobalColors().primaryRed,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
