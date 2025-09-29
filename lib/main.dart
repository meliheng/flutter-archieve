import 'package:anims/auto_routes/app_router.dart';
import 'package:anims/go_router/go_app_router.dart';
import 'package:anims/list/insta_list.dart';
import 'package:anims/player/view/song_list.dart';
import 'package:anims/scroll/infinite_scroll_view.dart';
import 'package:anims/views/slide/slide_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isDark = false;
  void toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: InstaList(),
    );
  }
}
