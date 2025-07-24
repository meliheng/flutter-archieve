import 'package:anims/components/change_theme_button.dart';
import 'package:flutter/material.dart';

class Lifecycles extends StatelessWidget {
  final VoidCallback toggleTheme;
  const Lifecycles({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lifecycles'),
        actions: [ChangeThemeButton(toggleTheme: toggleTheme)],
      ),
      body: Center(
        child: Text(
          'Current Theme: ${Theme.of(context).brightness == Brightness.dark ? "Dark" : "Light"}',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}
