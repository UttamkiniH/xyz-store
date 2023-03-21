import 'package:flutter/material.dart';

import 'screens.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "xyz".toPng(),
              width: 10 * 15,
              height: 10 * 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Text('XYZ Store', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
                child: const Text("Get Started")),
          ],
        ),
      ),
    );
  }
}

extension on String {
  toPng() {
    return 'assets/icons/$this.png';
  }
}
