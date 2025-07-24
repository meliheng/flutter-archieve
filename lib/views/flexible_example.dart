import 'package:flutter/material.dart';

class FlexibleExample extends StatelessWidget {
  const FlexibleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flexible Example')),
      body: Column(
        children: [
          Flexible(
            child: SizedBox(
              height: 200,
              child: const Center(
                child: Text(
                  'Flexible FLexible Flexible Flexible e Flexible Flexible Flexible Flexiblee Flexible Flexible Flexible Flexible e Flexible Flexible Flexible Flexible e Flexible Flexible Flexible Flexible e Flexible Flexible Flexible Flexible',
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              child: const Center(child: Text('Expanded')),
            ),
          ),
        ],
      ),
    );
  }
}
