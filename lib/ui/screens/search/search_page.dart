import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:xyz_store/data/data.dart';
import 'package:xyz_store/providers/providers.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController searchController = TextEditingController();
  bool showData = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  findIndex(String pid) {
    List<ProductModel> products = context.read<ProductProvider>().productData;
    var temp = products.indexWhere((element) => element.id.contains(pid));
    print(temp);
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        toolbarHeight: 80,
        title: TextFormField(
          cursorColor: Colors.white,
          controller: searchController,
          enableSuggestions: true,
          onFieldSubmitted: (_) {
            print(_);
            setState(() {
              showData = true;
            });
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 2, color: Colors.white60),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.white, width: 2)),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white54,
            ),
            suffixIcon: IconButton(
                icon: const Icon(
                  Icons.close_sharp,
                  color: Colors.white54,
                ),
                onPressed: () {
                  searchController.clear();
                  setState(() {
                    showData = false;
                  });
                }),
            labelText: "Search For Products",
            labelStyle: const TextStyle(color: Colors.white54),
          ),
        ),
      ),
      body: showData
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("product")
                  .where(
                    "keywords",
                    arrayContains: searchController.text,
                  )
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          String data =
                              (snapshot.data! as dynamic).docs[index]['id'];
                          int id = findIndex(data);
                          context.pushNamed('description_page',
                              params: {'id': id.toString()});
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                (snapshot.data! as dynamic).docs[index]
                                    ['images'][0]),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          title: Text(
                              (snapshot.data! as dynamic).docs[index]['name']),
                        ),
                      );
                    });
              },
            )
          : const Center(
              child: Text("🔎 Search For Products "),
            ),
    );
  }
}
