import 'package:anims/auto_routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsDetailView extends StatelessWidget {
  const SettingsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    print("settings detail view build");
    return Scaffold(
      appBar: AppBar(title: const Text('Settings Detail View')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.router.push(ResultRoute());
              },
              child: Text("Hello"),
            ),
          ],
        ),
      ),
    );
  }
}
