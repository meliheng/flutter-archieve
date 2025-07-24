import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<String> _suggestions = ['gmail.com', 'hotmail.com', 'outlook.com'];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(() {
      setState(() {
        _showSuggestions =
            _focusNode.hasFocus && _controller.text.contains('@');
      });
    });
  }

  void _onTextChanged() {
    final text = _controller.text;
    setState(() {
      _showSuggestions =
          _focusNode.hasFocus &&
          text.contains('@') &&
          !text.split('@')[1].contains('.');
    });
  }

  void _onSuggestionTap(String domain) {
    final parts = _controller.text.split('@');
    if (parts.length > 1) {
      final newText = '${parts[0]}@$domain';
      _controller.text = newText;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: newText.length),
      );
      setState(() {
        _showSuggestions = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Text('Login View', style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            if (_showSuggestions)
              Align(
                alignment: Alignment.bottomCenter,
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        _suggestions.map((domain) {
                          return TextButton(
                            onPressed: () => _onSuggestionTap(domain),
                            child: Text(domain),
                          );
                        }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
