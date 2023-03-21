import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:xyz_store/common/app_colors.dart';
import 'package:xyz_store/providers/providers.dart';

class GetLocationPage extends StatefulWidget {
  const GetLocationPage({super.key});

  @override
  State<GetLocationPage> createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.location_on_outlined),
          onPressed: () async {
            await context.read<FetchLocationProvider>().determinePostion();
          },
          label: context.watch<FetchLocationProvider>().address != null
              ? InkWell(
                  onTap: () => context.pushNamed('orders'),
                  child: const Text("Confirm this address"),
                )
              : const Text("Detect my Location")),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        elevation: 0.0,
        iconTheme: IconThemeData(color: GlobalColors().primaryRed),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: LottieBuilder.asset('assets/lottie/location.json'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              context.watch<FetchLocationProvider>().address ??
                  "Your location will apppear here",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
