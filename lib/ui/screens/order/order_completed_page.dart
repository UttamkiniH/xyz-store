import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: LottieBuilder.asset('assets/lottie/order-completed.json'),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                context.goNamed('home', params: {'index': 0.toString()});
              },
              child: const Text("Shop for more"))
        ],
      ),
    );
  }
}
