import 'package:flutter/material.dart';

class ChangeThemeButton extends StatefulWidget {
  final VoidCallback toggleTheme;
  const ChangeThemeButton({super.key, required this.toggleTheme});

  @override
  State<ChangeThemeButton> createState() => _ChangeThemeButtonState();
}

class _ChangeThemeButtonState extends State<ChangeThemeButton> {
  late Brightness brightness;

  @override
  void initState() {
    super.initState();
    print("initState çağrıldı");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Bu metod Theme, MediaQuery gibi context bağımlı değerler değiştiğinde çağrılır.
    brightness = Theme.of(context).brightness;
    print("didChangeDependencies çağrıldı: $brightness");
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.dark_mode),
      onPressed: widget.toggleTheme,
    );
  }
}
