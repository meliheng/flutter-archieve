import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PaywallView extends StatelessWidget {
  const PaywallView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(context.router.runtimeType.toString());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text('Paywall View'),
            ElevatedButton(
              onPressed: () {
                context.router.pop();
              },
              child: Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
