import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xyz_store/common/app_colors.dart';
import 'package:xyz_store/data/data.dart';
import 'package:xyz_store/ui/widgets/widgets.dart';

import '../../../providers/providers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _productStreams =
      FirebaseFirestore.instance.collection('product').snapshots();

  @override
  Widget build(BuildContext context) {
    //*same as the cartpage
    List<ProductModel> productData =
        context.watch<ProductProvider>().productData;

    return Scaffold(
        appBar: CustomAppBar(textString: "Products"),
        body: StreamBuilder<QuerySnapshot>(
          stream: _productStreams,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: productData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (2 / 4),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0),
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      //*Description page route
                      context.pushNamed('description_page',
                          params: {'id': index.toString()});
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Image.network(
                                productData[index].images[0],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            productData[index].name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Rs. ${productData[index].price.toString()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: GlobalColors().primaryRed),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              );
            }

            return const Center(
              child: Text("No Data has been fetched"),
            );
          },
        ));

    //
  }
}
