import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({super.key});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(-1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Card')),
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _selectedIndex.value = _selectedIndex.value == index ? -1 : index;
              },
              child: ValueListenableBuilder(
                valueListenable: _selectedIndex,
                builder: (context, value, child) {
                  return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selectedIndex.value == index
                          ? Colors.red
                          : Colors.transparent,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: [
                      Text("Card $index", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}