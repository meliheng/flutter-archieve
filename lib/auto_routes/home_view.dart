import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home View')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Home View!'),
            ElevatedButton(
              onPressed: () {
                // context.router.pushNamed('/details');
              },
              child: const Text('Go to Details View'),
            ),
          ],
        ),
      ),
    );
  }
}
