import 'package:anims/auto_routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(title: const Text('Profile View')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Profile View!'),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (innerContext) {
                    return Container(
                      height: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          innerContext.router.pop();
                          innerContext.router.push(ProfileDetailRoute());
                        },
                        child: Text("Go Detail"),
                      ),
                    );
                  },
                );
                // context.router.pushNamed('/settings');
              },
              child: const Text('Go to Profil Detail View'),
            ),
          ],
        ),
      ),
    );
  }
}
