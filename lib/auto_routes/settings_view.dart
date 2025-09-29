import 'package:anims/auto_routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    print("settings view build");
    return Scaffold(
      appBar: AppBar(title: const Text('Settings View')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.router.push(SettingsDetailRoute());
              },
              child: Text("Hello"),
            ),
          ],
        ),
      ),
    );
  }
}
