import 'package:flutter/material.dart';

class Slivers extends StatefulWidget {
  const Slivers({super.key});

  @override
  State<Slivers> createState() => _SliversState();
}

class _SliversState extends State<Slivers> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: ScrollController(),
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                title: Text('SliverAppBar'),
                expandedHeight: 400,
                pinned: true,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    'https://picsum.photos/200/300',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// 🔴 Bu container appbar'ın altına geldiğinde sabitlenir
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverHeaderDelegate(
                  height: 100,
                  child: Container(
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: Text(
                      "AppBar Altında Sabitlenir",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
        body: TabBarView(
          controller: _tabController,
          children: [
            /// Bu kısımlar scrollable değil, çünkü tüm scroll NestedScrollView'da
            ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 20,
              itemBuilder:
                  (context, index) =>
                      ListTile(title: Text("First Tab - Item #$index")),
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 20,
              itemBuilder:
                  (context, index) =>
                      ListTile(title: Text("Second Tab - Item #$index")),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _SliverHeaderDelegate({required this.child, required this.height});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant _SliverHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}
