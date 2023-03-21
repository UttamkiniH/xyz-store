import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),
        () => context.goNamed('home', params: {'index': 0.toString()}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: LottieBuilder.asset('assets/lottie/xyz.json'),
            ),
          ),
          Text(
            'Loading..',
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
