import 'package:anims/components/size_reporting_widget.dart';
import 'package:flutter/material.dart';

class ExpandablePageView extends StatefulWidget {
  const ExpandablePageView({super.key});

  @override
  State<ExpandablePageView> createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView> {
  final PageController _pageController = PageController();
  final List<String> _items = [
    "lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
    "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    "Curabitur pretium tincidunt lacus. Nulla gravida orci a odio. Nullam varius, turpis et commodo pharetra, est eros bibendum elit, nec luctus magna felis sollicitudin.",
  ];
  int _currentPage = 0;
  late Map<int, double> _heights;

  @override
  void initState() {
    super.initState();
    _heights = {
      for (var item in List.generate(_items.length, (index) => index)) item: 0,
    };
    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? 0;
      if (newPage != _currentPage) {
        setState(() {
          _currentPage = newPage;
        });
      }
    });
  }

  void _onSizeReported(int pageIndex, Size size) {
    if (_heights[pageIndex] != size.height) {
      setState(() {
        _heights[pageIndex] = size.height;
        if (pageIndex == _currentPage) {}
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expandable Page View')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: _heights[_currentPage], // Default height if not reported
              child: PageView.builder(
                controller: _pageController,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return OverflowBox(
                    minHeight: 0,
                    maxHeight: double.infinity,
                    child: SizeReportingWidget(
                      onSizeChange: (size) => _onSizeReported(index, size),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(_items[index]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
