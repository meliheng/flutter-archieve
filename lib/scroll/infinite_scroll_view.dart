import 'package:flutter/material.dart';

class InfiniteScrollView extends StatefulWidget {
  const InfiniteScrollView({super.key});

  @override
  State<InfiniteScrollView> createState() => _InfiniteScrollViewState();
}

class _InfiniteScrollViewState extends State<InfiniteScrollView> {
  final ScrollController _scrollController = ScrollController();
  final List<String> items = List.generate(140, (index) => 'Item $index');
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _onScroll() async {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading) {
      // print('scrolled to the bottom');
      // isLoading = true;
      // setState(() {});
      // await Future.delayed(Duration(seconds: 2));
      // items.addAll(
      //   List.generate(20, (index) => 'Item ${items.length + index + 1}'),
      // );
      // isLoading = false;
      // setState(() {});
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Text('items: ${items.length}'),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == items.length) {
                  return Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(items[index], style: TextStyle(fontSize: 20)),
                );
              },
              itemCount: isLoading ? items.length + 1 : items.length,
            ),
          ],
        ),
      ),
    );
  }
}
