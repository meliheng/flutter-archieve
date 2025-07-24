import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

class NumerologyView extends StatefulWidget {
  const NumerologyView({super.key});

  @override
  State<NumerologyView> createState() => _NumerologyViewState();
}

class _NumerologyViewState extends State<NumerologyView> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      // print(_pageController.page);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose(); // unutma

    _selectedIndex.dispose();
    super.dispose();
  }

  void _centerTab(int index) {
    double itemWidth = 100 + 8.0 * 2 + 4.0 * 2;
    double screenWidth = MediaQuery.of(context).size.width;
    double offset = itemWidth * index - screenWidth / 2 + itemWidth / 2;

    if (!_scrollController.hasClients) return;

    offset = offset.clamp(
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = getNumerologyData();
    return Scaffold(
      appBar: AppBar(title: const Text('Numerology View')),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: ValueListenableBuilder(
              valueListenable: _selectedIndex,
              builder:
                  (context, selected, child) => ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final isSelected = selected == index;
                      return GestureDetector(
                        onTap: () {
                          _pageController.jumpToPage(index);
                          _centerTab(index);
                        },
                        child: Container(
                          width: 100,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Colors.blue : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(index.toString()),
                        ),
                      );
                    },
                  ),
            ),
          ),
          ExpandablePageView.builder(
            controller: _pageController,
            itemCount: data.length,
            onPageChanged: (index) {
              print("onPageChanged: $index");
              _selectedIndex.value = index;
              _centerTab(index);
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(data[index], style: const TextStyle(fontSize: 18)),
              );
            },
          ),
        ],
      ),
    );
  }
}

List<String> getNumerologyData() {
  // This function should return a list of numerology data.
  // For now, we return an empty list.
  return [
    "Numerology data will be displayed here. Please implement the logic to fetch and display numerology data.",
    "You can use this space to show various numerology calculations and interpretations.",
    "Consider adding features like life path numbers, destiny numbers, and personality numbers.",
    "You can also include explanations of each number's significance in numerology.",
  ];
}
