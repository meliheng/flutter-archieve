import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileDetailView extends StatelessWidget {
  const ProfileDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Detail View')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Profile Detail View!'),
            ElevatedButton(
              onPressed: () {
                context.router.popUntilRoot();
                // context.router.pushNamed('/settings');
              },
              child: const Text('Go to Settings View'),
            ),
          ],
        ),
      ),
    );
  }
}
