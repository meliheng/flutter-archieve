import 'package:anims/auto_routes/app_router.dart';
import 'package:anims/auto_routes/popup_cubit.dart';
import 'package:anims/image_preview/image_preview2.dart';
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

  final appRouter = AppRouter();
  final popupCubit = PopupCubit();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      // routerDelegate: appRouter.delegate(
      //   navigatorObservers: () => [AppRouteObserver(appRouter, popupCubit)],
      // ),
      // routeInformationParser: appRouter.defaultRouteParser(),
      // builder: (context, child) =>
      //     BlocProvider.value(value: popupCubit, child: child),
      home: ImagePreview2(),
    );
  }
}
